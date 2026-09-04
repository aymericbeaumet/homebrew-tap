class Aggr < Formula
  desc "Git-native feed reader: aggr.toml in, static site out, history on a branch"
  homepage "https://github.com/aymericbeaumet/aggr"
  url "https://github.com/aymericbeaumet/aggr/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "2a26f89762b1a920b9d3c82de4f28114cce95cf639f936d3cbdab892ef3f1012"
  license "MIT"
  head "https://github.com/aymericbeaumet/aggr.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aggr --version")
  end
end
