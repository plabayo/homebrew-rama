# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/0.2.0-alpha.8/rama.aarch64-apple-darwin.tar.xz"
    sha256 "4538a083a17adf266e66a220746a12cff65cce134e3b1be89b9f5c8eb0b4a7d5"
    version "0.2.0-alpha.9"
  
    def install
      bin.install "rama"
    end
  end
