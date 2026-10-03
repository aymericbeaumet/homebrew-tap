# This cask is automatically updated by aymericbeaumet/flash. DO NOT EDIT.

cask "flash@nightly" do
  version "nightly-20261003-8d9f2ae0"
  sha256 "5c63ef50b10475ca81e6f0e3d370367309a09ad7c762fe12c2dc458ec5422b34"

  url "https://github.com/aymericbeaumet/flash/releases/download/nightly/Flash-nightly-20261003-8d9f2ae0.zip",
      verified: "github.com/aymericbeaumet/flash/"
  name "Flash"
  desc "Keyboard hints to click any on-screen control"
  homepage "https://github.com/aymericbeaumet/flash"

  depends_on macos: ">= :sonoma"

  app "Flash.app"
  binary "#{appdir}/Flash.app/Contents/MacOS/flash", target: "flash"

  # Autostart is owned by the app (SMAppService, [app] autostart). Remove the
  # LaunchAgent that earlier casks installed, then start Flash so it registers
  # its login item and walks the user through the Accessibility grant.
  postflight do
    legacy_agent = File.expand_path("~/Library/LaunchAgents/com.flash.app.autolaunch.plist")
    if File.exist?(legacy_agent)
      system_command "/bin/launchctl",
                     args: ["bootout", "gui/#{Process.uid}", legacy_agent],
                     must_succeed: false
      File.delete(legacy_agent)
    end
    system_command "/usr/bin/open",
                   args: ["-g", "#{appdir}/Flash.app"],
                   must_succeed: false
  end

  uninstall quit: "com.flash.app"

  zap trash: [
    "~/.config/flash",
    "~/Library/Application Support/Flash",
    "~/Library/Logs/Flash",
  ]

  caveats <<~EOS
    Flash needs the Accessibility permission to read and click controls:
      System Settings → Privacy & Security → Accessibility

    Flash is not notarized yet. If macOS blocks the first launch, allow it in
      System Settings → Privacy & Security → Open Anyway
  EOS
end
