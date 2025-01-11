class Erun < Formula
  desc "CLI tool to launch iOS simulators and Android emulators"
  homepage "https://github.com/alaev-dev/erun"
  url "https://github.com/alaev-dev/erun/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "2dc9fbe707051d76bfb926c61bddb0f130418b3eede3e787b885ecc8a5f7bd59"
  license "MIT"
  depends_on "dart-sdk"

  def install
    system "dart", "pub", "get"
    system "dart", "compile", "exe", "bin/erun.dart", "-o", "erun"
    bin.install "erun"
  end

  test do
    system "#{bin}/erun"
  end
end 