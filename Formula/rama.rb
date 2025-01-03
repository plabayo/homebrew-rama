# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/0.2.0-alpha.4/rama-aarch64-apple-darwin.tar.gz"
    sha256 "201d1d414fe41211dc800c7d89c6bf71ab0c481c4cb0777c30a44bec07052d7e"
    version "0.2.0-alpha.4"
  
    def install
      bin.install "rama"
    end
  end
