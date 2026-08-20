class Rama < Formula
  desc "Move and transform network packets"
  homepage "https://ramaproxy.org"
  url "https://github.com/plabayo/rama/releases/download/rama-0.4.0/rama.aarch64-apple-darwin.tar.xz"
  sha256 "0483f9a7928a1eb561f15a3ba384334d1606ab0ed3cb4533cef7af543564df65"
  license "MIT"

  livecheck do
    url "https://github.com/plabayo/rama/releases"
    regex(%r{href=.*?/releases/tag/rama[._-]v?(\d+(?:\.\d+)+)["' >]}i)
  end

  depends_on :macos

  resource "rama-intel" do
    on_intel do
      url "https://github.com/plabayo/rama/releases/download/rama-0.4.0/rama.x86_64-apple-darwin.tar.xz"
      sha256 "1558de74ab46e5f0b877ecb45048e40802256a98fdbd93b7437e64f066ca020e"
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
    assert_match version.to_s, shell_output("#{bin}/rama --version")
  end
end
