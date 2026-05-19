# This formula is automatically updated on every push to master. DO NOT EDIT.

class SqueezeNightly < Formula
  desc "Extract rich information from any text (URIs, codetags, etc.) - nightly"
  homepage "https://github.com/aymericbeaumet/squeeze"
  url "https://github.com/aymericbeaumet/squeeze/archive/eda7ad22875866a9040a08d2e626f63ff9984dca.tar.gz"
  version "nightly-20260519-eda7ad2"
  sha256 "90823eed8ef8cfcc852842b0eb4fec06f1fafab936b768e20165c1c6be0a9099"
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
