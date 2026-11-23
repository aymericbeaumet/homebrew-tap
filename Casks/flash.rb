# This cask is automatically updated by aymericbeaumet/flash. DO NOT EDIT.

cask "flash" do
  version "2.0.0"
  sha256 "cd9778d5e9beef398fbe854b84aa1335246079fe82e389c46e037e22f824f394"

  url "https://github.com/aymericbeaumet/flash/releases/download/2.0.0/Flash-2.0.0.zip",
      verified: "github.com/aymericbeaumet/flash/"
  name "Flash"
  desc "Keyboard hints to click any on-screen control"
  homepage "https://github.com/aymericbeaumet/flash"

  # Flash updates itself in place ([app] updates, docs/updates.md), so
  # brew upgrade leaves it alone unless run with --greedy.
  auto_updates true
  depends_on macos: ">= :ventura"

  app "Flash.app"
  binary "#{appdir}/Flash.app/Contents/MacOS/flash", target: "flash"
  manpage "#{appdir}/Flash.app/Contents/Resources/flash.1"
  bash_completion "#{appdir}/Flash.app/Contents/Resources/completions/flash.bash"
  zsh_completion "#{appdir}/Flash.app/Contents/Resources/completions/_flash"
  fish_completion "#{appdir}/Flash.app/Contents/Resources/completions/flash.fish"

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
