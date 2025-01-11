class Erun < Formula
  desc "CLI tool to launch iOS simulators and Android emulators"
  homepage "https://github.com/alaev-dev/erun"
  url "https://github.com/alaev-dev/erun/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "e5d979c1b16c03f7c8dabdd6b1a1124f4104df1db748fd7c5d8f841129399c0d"
  license "MIT"
  depends_on "dart-sdk"

  def install
    system "dart", "pub", "get"
    system "dart", "compile", "exe", "bin/erun.dart", "-o", "erun"
    bin.install "erun"
  end

  test do
    system "#{bin}/erun", "--version"
  end
end 