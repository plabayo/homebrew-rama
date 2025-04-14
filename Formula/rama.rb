# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/0.2.0-alpha.8/rama.aarch64-apple-darwin.tar.xz"
    sha256 "1180dcbaac0ea7df6a537455b14286677d19364b9eb72a98952e3854803920f7"
    version "0.2.0-alpha.8"
  
    def install
      bin.install "rama"
    end
  end
