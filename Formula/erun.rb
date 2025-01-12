class Erun < Formula
  desc "CLI tool to launch iOS simulators and Android emulators"
  homepage "https://github.com/alaev-dev/erun"
  url "https://github.com/alaev-dev/erun/archive/refs/tags/v1.0.8.tar.gz"
  sha256 "965b4ad0cf01a1a4678ab29dbf966e28157477633122984456cc4416f8456012"
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