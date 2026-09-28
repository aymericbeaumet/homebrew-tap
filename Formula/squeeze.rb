# frozen_string_literal: true

# Stable version fields are maintained by squeeze's release workflow.
class Squeeze < Formula
  desc "Extract rich information from any text (URIs, codetags, etc.)"
  homepage "https://github.com/aymericbeaumet/squeeze"
  url "https://github.com/aymericbeaumet/squeeze/archive/refs/tags/v0.3.0.tar.gz"
  version "0.3.0"
  sha256 "5631f550c06369497b14abfb737c666ec99292fdd29bd1b75c41890e472c09f9"
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
