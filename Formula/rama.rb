# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/0.2.0-alpha.8/rama.aarch64-apple-darwin.tar.xz"
    sha256 "88c9d3f6eb6aaa96e6f49787491c829cc18b5dfb7999f76c42b1ce42978145bb"
    version "0.2.0-alpha.14"
  
    def install
      bin.install "rama"
    end
  end
