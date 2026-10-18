# This formula is automatically updated on every push to main. DO NOT EDIT.

class SqueezeNightly < Formula
  desc "Extract rich information from any text (URIs, codetags, etc.) - nightly"
  homepage "https://github.com/aymericbeaumet/squeeze"
  url "https://github.com/aymericbeaumet/squeeze/archive/d70d12cce16bb89ebc2c8359ec1f1b72af39749a.tar.gz"
  version "nightly-20261018-d70d12c"
  sha256 "6ed8a863498c962c84a457a7007f9b268522f61c458097fde88453ef3cfaec9b"
  license "MIT"

  depends_on "rust" => :build

  conflicts_with "squeeze", because: "squeeze-nightly and squeeze install the same binary"

  def install
    ENV["SQUEEZE_VERSION"] = version.to_s
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    output = pipe_output("\#{bin}/squeeze --url", "visit https://example.com today")
    assert_equal "https://example.com", output.strip
  end
end
