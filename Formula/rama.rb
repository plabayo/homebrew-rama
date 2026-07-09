class Rama < Formula
  desc "Move and transform network packets"
  homepage "https://ramaproxy.org"
  version "0.3.0"
  license "MIT"

  url "https://github.com/plabayo/rama/releases/download/rama-0.3.0/rama.aarch64-apple-darwin.tar.xz"
  sha256 "9d70fb9b80fdcf42f474605defc3a6609bad81b5b91b16695f25a07b8be0d899"

  on_intel do
    url "https://github.com/plabayo/rama/releases/download/rama-0.3.0/rama.x86_64-apple-darwin.tar.xz"
    sha256 "8dba0f012da6e2242d254373abab62c9246dca0f712e2849510619f3d7af7a51"
  end

  depends_on :macos

  livecheck do
    url "https://github.com/plabayo/rama/releases"
    regex(/href=.*?\/releases\/tag\/rama[._-]v?(\d+(?:\.\d+)+)["' >]/i)
  end

  def install
    bin.install "rama"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rama --version")
  end
end
