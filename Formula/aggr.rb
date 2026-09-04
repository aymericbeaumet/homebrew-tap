class Aggr < Formula
  desc "Git-native feed reader: aggr.toml in, static site out, history on a branch"
  homepage "https://github.com/aymericbeaumet/aggr"
  url "https://github.com/aymericbeaumet/aggr/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "022a060e5528f121c7236660f8e4101dd1af75aa229ca52b24eefcab2efbab9b"
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
