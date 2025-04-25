# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/0.2.0-alpha.8/rama.aarch64-apple-darwin.tar.xz"
    sha256 "616894751fc23b7de7e47d225b227c98d01a7bc38dc9bb5cd5e4e9a1dcbb7815"
    version "0.2.0-alpha.13"
  
    def install
      bin.install "rama"
    end
  end
