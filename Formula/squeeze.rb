# frozen_string_literal: true

# Stable version fields are maintained by squeeze's release workflow.
class Squeeze < Formula
  desc "Extract rich information from any text (URIs, codetags, etc.)"
  homepage "https://github.com/aymericbeaumet/squeeze"
  url "https://github.com/aymericbeaumet/squeeze/archive/refs/tags/v0.2.0.tar.gz"
  version "0.2.0"
  sha256 "8b933497dbef1272edae00d02879426723d3ea5f56b124518efa8fc958022b62"
  license "MIT"
  head "https://github.com/aymericbeaumet/squeeze.git", branch: "main"

  depends_on "rust" => :build

  conflicts_with "squeeze-nightly", because: "squeeze-nightly and squeeze install the same binary"

  def install
    system "cargo", "install", *std_cargo_args(path: "squeeze-cli")
  end

  test do
    output = pipe_output("#{bin}/squeeze --url", "visit https://example.com today")
    assert_equal "https://example.com", output.strip
  end
end
