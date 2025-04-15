# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/0.2.0-alpha.8/rama.aarch64-apple-darwin.tar.xz"
    sha256 "7db3e0292b64d2b060fa93532d92f091d34db23ecb5beace703490032c072dba"
    version "0.2.0-alpha.10"
  
    def install
      bin.install "rama"
    end
  end
