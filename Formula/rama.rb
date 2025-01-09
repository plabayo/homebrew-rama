# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/0.2.0-alpha.6/rama-aarch64-apple-darwin.tar.gz"
    sha256 "6648befc960dc670b3342adb6f621f18993e05c27c95efcb47f53519cae26ce3"
    version "0.2.0-alpha.6"
  
    def install
      bin.install "rama"
    end
  end
