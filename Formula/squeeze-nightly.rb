# This formula is automatically updated on every push to master. DO NOT EDIT.

class SqueezeNightly < Formula
  desc "Extract rich information from any text (URIs, codetags, etc.) - nightly"
  homepage "https://github.com/aymericbeaumet/squeeze"
  url "https://github.com/aymericbeaumet/squeeze/archive/38d59c455d82502846402ac07e5766a1c09c9221.tar.gz"
  version "nightly-20260517-38d59c4"
  sha256 "79b3d26fec0fe3c472419ae8fe2441ff4c91a5a66c15e85be66fbfa5be92e120"
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
