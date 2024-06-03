# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/0.2.0-alpha.0/rama-aarch64-apple-darwin.tar.gz"
    sha256 "6c62fcacf57f9de6652be3ebb75be2248a54459a3279dc0ab135905ae32def53"
    version "0.2.0-alpha.0"
  
    def install
      bin.install "rama"
    end
  end