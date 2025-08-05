# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/0.3.0-alpha.2/rama.aarch64-apple-darwin.tar.xz"
    sha256 "1d9fd1ab28e916d15d9ece04c5280136bc477d750a9ecd90b837173ff43f2c23"
    version "0.2.0"
  
    def install
      bin.install "rama"
    end
  end
