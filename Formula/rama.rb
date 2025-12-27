# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/rama-0.3.0-alpha.4/rama.aarch64-apple-darwin.tar.xz"
    sha256 "94b13f5564bfe0431cf4d951ac6d963e930d333e6906354ba72b7e3e9862103d"
    version "0.3.0"
  
    def install
      bin.install "rama"
    end
  end
