# This formula is automatically updated on every push to main. DO NOT EDIT.

class SqueezeNightly < Formula
  desc "Extract rich information from any text (URIs, codetags, etc.) - nightly"
  homepage "https://github.com/aymericbeaumet/squeeze"
  url "https://github.com/aymericbeaumet/squeeze/archive/dd100a32718f2a3a6ae1ed60d07dbd68f4877e5e.tar.gz"
  version "nightly-20260805-dd100a3"
  sha256 "f182a88969da3bb71cde0c66f86efe0d7dba1cbbb7a625eea344ff649cfaf0b9"
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
