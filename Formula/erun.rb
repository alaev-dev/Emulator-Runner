class Erun < Formula
  desc "CLI tool to launch iOS simulators and Android emulators"
  homepage "https://github.com/alaev-dev/erun"
  url "https://github.com/alaev-dev/erun/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "9fafec0ff1be81d72a4eae5e0f040b6d809b568732f6950d628cbac3fc4b81e7"
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