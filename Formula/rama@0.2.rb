class RamaAT02 < Formula
  desc "Move and transform network packets"
  homepage "https://ramaproxy.org"
  url "https://github.com/plabayo/rama/releases/download/rama-0.2.0/rama.aarch64-apple-darwin.tar.xz"
  version "0.2.0"
  sha256 "8ec856d67c17bdeb6fc666cb2f3abf95f53c9929be49efd92b10731b78136eae"
  license "MIT"

  resource "rama-intel" do
    on_intel do
      url "https://github.com/plabayo/rama/releases/download/rama-0.2.0/rama.x86_64-apple-darwin.tar.xz"
      sha256 "0d43f691e4b4aa235f569d4a8df91861a95340f388a9c6d3fe804a23693606f8"
    end
  end

  livecheck do
    url "https://github.com/plabayo/rama/releases"
    regex(%r{href=.*?/releases/tag/rama[._-]v?(0\.2\.\d+)["' >]}i)
  end

  depends_on :macos

  keg_only :versioned_formula

  def install
    if Hardware::CPU.intel?
      resource("rama-intel").stage { bin.install "rama" }
      return
    end

    bin.install "rama"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rama --version")
  end
end
