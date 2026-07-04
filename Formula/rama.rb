# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Rama < Formula
    desc "move and transform network packets with rama"
    homepage "https://ramaproxy.org"
    url "https://github.com/plabayo/rama/releases/download/rama-0.3.0-rc.1/rama.aarch64-apple-darwin.tar.xz"
    sha256 "43873bf9ac5656a398581ca7e2b2c0d5b2de5ffdc57784180a307e5b193c4803"
    version "0.3.0"
  
    def install
      bin.install "rama"
    end
  end
