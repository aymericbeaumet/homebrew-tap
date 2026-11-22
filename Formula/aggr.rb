class Aggr < Formula
  desc "Git-native feed reader: aggr.toml in, static site out"
  homepage "https://github.com/aymericbeaumet/aggr"
  version "3.0.1"
  license "MIT"
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/aymericbeaumet/aggr/releases/download/v3.0.1/aggr-darwin-arm64.tar.gz"
      sha256 "119b592b2ff8c79d3a5cac4cbecb9c9b268103bdef0130001cd2869510b7938f"
    end
    on_intel do
      url "https://github.com/aymericbeaumet/aggr/releases/download/v3.0.1/aggr-darwin-amd64.tar.gz"
      sha256 "4b29890953db7172547debe53e5cea181360c9d442dee184f1b16e160696dc72"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/aymericbeaumet/aggr/releases/download/v3.0.1/aggr-linux-arm64.tar.gz"
      sha256 "3119202ce8656279fce404774e33d34f8ccdbe654776d08373525e94cf89f3bd"
    end
    on_intel do
      url "https://github.com/aymericbeaumet/aggr/releases/download/v3.0.1/aggr-linux-amd64.tar.gz"
      sha256 "8b7dcd88316cc29a12c1dd3b7ceb51ba6c029b1f3da1ad516a15e61678687012"
    end
  end

  def install
    bin.install "aggr"
    pkgshare.install "THIRD_PARTY_NOTICES"
  end

  test do
    assert_match "aggr #{version}", shell_output("#{bin}/aggr --version")
    assert_match "--no-watch", shell_output("#{bin}/aggr dev --help")
    system "#{bin}/aggr", "init"
    assert_path_exists testpath/"aggr.toml"
  end
end
