# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/0.2.0-alpha.5/rama-aarch64-apple-darwin.tar.gz"
    sha256 "4c14b7144b95601e22c97604364ab53774a62ab897c7be560dd050ceb1f2cab6"
    version "0.2.0-alpha.5"
  
    def install
      bin.install "rama"
    end
  end
