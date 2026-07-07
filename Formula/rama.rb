# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/rama-0.3.0/rama.aarch64-apple-darwin.tar.xz"
    sha256 "9d70fb9b80fdcf42f474605defc3a6609bad81b5b91b16695f25a07b8be0d899"
    version "0.3.0"
  
    def install
      bin.install "rama"
    end
  end
