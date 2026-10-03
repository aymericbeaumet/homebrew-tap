# This formula is automatically updated on every push to main. DO NOT EDIT.

class SqueezeNightly < Formula
  desc "Extract rich information from any text (URIs, codetags, etc.) - nightly"
  homepage "https://github.com/aymericbeaumet/squeeze"
  url "https://github.com/aymericbeaumet/squeeze/archive/c0fdb4b34411f4ee03dd547731bf0fcbb6ba373a.tar.gz"
  version "nightly-20261003-c0fdb4b"
  sha256 "eb3ab9b48aed652ef1269673915c1ff4080a44d156045e9e54cc38621fab60f6"
  license "MIT"

  depends_on "rust" => :build

  conflicts_with "squeeze", because: "squeeze-nightly and squeeze install the same binary"

  def install
    ENV["SQUEEZE_VERSION"] = version.to_s
    system "cargo", "install", *std_cargo_args(path: "squeeze-cli")
  end

  test do
    output = pipe_output("\#{bin}/squeeze --url", "visit https://example.com today")
    assert_equal "https://example.com", output.strip
  end
end
