#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "net/http"
require "optparse"
require "pathname"
require "uri"

OWNER = "plabayo"
REPO = "rama"
VERSIONED_FORMULA_LIMIT = 4
MACOS_TARGETS = {
  arm: "aarch64-apple-darwin",
  intel: "x86_64-apple-darwin",
}.freeze

options = {
  version: "latest",
  versioned: true,
  versioned_limit: VERSIONED_FORMULA_LIMIT,
}

OptionParser.new do |parser|
  parser.banner = "Usage: scripts/update-formula.rb [options]"
  parser.on("--version VERSION", "Rama version or release tag to package, defaults to latest stable") do |version|
    options[:version] = version
  end
  parser.on("--[no-]versioned", "Maintain previous stable minor formulae, defaults to true") do |versioned|
    options[:versioned] = versioned
  end
  parser.on("--versioned-limit LIMIT", Integer, "Maximum previous stable minor formulae to keep") do |limit|
    options[:versioned_limit] = limit
  end
end.parse!

def api_get(path)
  uri = URI("https://api.github.com#{path}")
  request = Net::HTTP::Get.new(uri)
  request["Accept"] = "application/vnd.github+json"
  request["User-Agent"] = "homebrew-rama-maintenance"
  request["Authorization"] = "Bearer #{ENV.fetch("GITHUB_TOKEN")}" if ENV["GITHUB_TOKEN"]

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
  abort "GitHub API request failed: #{uri} => #{response.code} #{response.message}" unless response.is_a?(Net::HTTPSuccess)

  JSON.parse(response.body)
end

def http_get(url, limit = 5)
  abort "Too many redirects while fetching #{url}" if limit.zero?

  uri = URI(url)
  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.get(uri.request_uri) }
  return http_get(response["location"], limit - 1) if response.is_a?(Net::HTTPRedirection)

  abort "HTTP request failed: #{url} => #{response.code} #{response.message}" unless response.is_a?(Net::HTTPSuccess)

  response.body
end

def normalize_version(version)
  version.delete_prefix("rama-").delete_prefix("v")
end

def stable_release?(release)
  !release.fetch("draft") && !release.fetch("prerelease") && normalize_version(release.fetch("tag_name")).match?(/\A\d+\.\d+\.\d+\z/)
end

def release_for_version(version)
  if version == "latest"
    api_get("/repos/#{OWNER}/#{REPO}/releases").find { |release| stable_release?(release) } ||
      abort("No stable Rama release found")
  else
    tag = version.start_with?("rama-") ? version : "rama-#{version}"
    api_get("/repos/#{OWNER}/#{REPO}/releases/tags/#{tag}")
  end
end

def sha_from_asset(asset)
  digest = asset["digest"].to_s
  return digest.delete_prefix("sha256:") if digest.start_with?("sha256:")

  checksum_url = "#{asset.fetch("browser_download_url")}.sha256"
  http_get(checksum_url).split.first
end

def macos_assets(release)
  version = normalize_version(release.fetch("tag_name"))

  MACOS_TARGETS.transform_values do |target|
    name = "rama.#{target}.tar.xz"
    asset = release.fetch("assets").find { |candidate| candidate.fetch("name") == name }
    abort "Release rama-#{version} is missing #{name}" unless asset

    {
      url: asset.fetch("browser_download_url"),
      sha256: sha_from_asset(asset),
    }
  end
end

def formula_class_for_versioned(version)
  major, minor = version.split(".")
  "RamaAT#{major}#{minor}"
end

def stable_minor(version)
  major, minor = version.split(".")
  "#{major}.#{minor}"
end

def render_formula(version:, assets:, versioned: false)
  klass = versioned ? formula_class_for_versioned(version) : "Rama"
  livecheck_regex = if versioned
    minor = Regexp.escape(stable_minor(version))
    "regex(%r{href=.*?/releases/tag/rama[._-]v?(#{minor}\\.\\d+)[\"' >]}i)"
  else
    "regex(%r{href=.*?/releases/tag/rama[._-]v?(\\d+(?:\\.\\d+)+)[\"' >]}i)"
  end

  <<~RUBY
    class #{klass} < Formula
      desc "Move and transform network packets"
      homepage "https://ramaproxy.org"
      url "#{assets.fetch(:arm).fetch(:url)}"
      version "#{version}"
      sha256 "#{assets.fetch(:arm).fetch(:sha256)}"
      license "MIT"

      livecheck do
        url "https://github.com/#{OWNER}/#{REPO}/releases"
        #{livecheck_regex}
      end

    #{versioned ? "  keg_only :versioned_formula\n\n" : ""}  depends_on :macos

      resource "rama-intel" do
        on_intel do
          url "#{assets.fetch(:intel).fetch(:url)}"
          sha256 "#{assets.fetch(:intel).fetch(:sha256)}"
        end
      end

      def install
        if Hardware::CPU.intel?
          resource("rama-intel").stage { bin.install "rama" }
          return
        end

        bin.install "rama"
      end

      test do
        assert_match version.to_s, shell_output("\#{bin}/rama --version")
      end
    end
  RUBY
end

def write_formula(path, contents)
  Pathname(path).write(contents)
  puts "wrote #{path}"
end

selected_release = release_for_version(options.fetch(:version))
selected_version = normalize_version(selected_release.fetch("tag_name"))
abort "Refusing to package non-stable release #{selected_release.fetch("tag_name")}" unless stable_release?(selected_release)

write_formula(
  "Formula/rama.rb",
  render_formula(version: selected_version, assets: macos_assets(selected_release)),
)

if options.fetch(:versioned)
  releases = api_get("/repos/#{OWNER}/#{REPO}/releases?per_page=100").select { |release| stable_release?(release) }
  previous_minor_releases = releases
    .reject { |release| normalize_version(release.fetch("tag_name")) == selected_version }
    .group_by { |release| stable_minor(normalize_version(release.fetch("tag_name"))) }
    .values
    .map(&:first)
    .first(options.fetch(:versioned_limit))

  expected_paths = previous_minor_releases.map do |release|
    version = normalize_version(release.fetch("tag_name"))
    minor = stable_minor(version)
    path = "Formula/rama@#{minor}.rb"
    write_formula(path, render_formula(version: version, assets: macos_assets(release), versioned: true))
    path
  end

  Dir["Formula/rama@*.rb"].each do |path|
    next if expected_paths.include?(path)

    File.delete(path)
    puts "removed #{path}"
  end
end
