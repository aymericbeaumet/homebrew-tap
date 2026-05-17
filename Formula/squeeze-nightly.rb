# This formula is automatically updated on every push to master. DO NOT EDIT.

class SqueezeNightly < Formula
  desc "Extract rich information from any text (URIs, codetags, etc.) - nightly"
  homepage "https://github.com/aymericbeaumet/squeeze"
  url "https://github.com/aymericbeaumet/squeeze/archive/ab79e4d649f5ab067b7e5dd83a9d6f33e195fb80.tar.gz"
  version "nightly-20260517-ab79e4d"
  sha256 "98b56bafda625d8aaebb0d1c560c67dee984202c56a0c844031e472e41ef46b8"
  license "MIT"

  depends_on "rust" => :build

  conflicts_with "squeeze", because: "squeeze-nightly and squeeze install the same binary"

  def install
    system "cargo", "install", *std_cargo_args(path: "squeeze-cli")
  end

  test do
    output = pipe_output("\#{bin}/squeeze --url", "visit https://example.com today")
    assert_equal "https://example.com", output.strip
  end
end
