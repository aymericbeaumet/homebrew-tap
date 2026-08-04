# This cask is automatically updated by aymericbeaumet/flash. DO NOT EDIT.

cask "flash@nightly" do
  version "nightly-20260804-aa90dbc0"
  sha256 "cce0a5cbea09b5e3dbeff70f97a1da4223ba9234c2ff0535c65f33735beff6c8"

  url "https://github.com/aymericbeaumet/flash/releases/download/nightly/Flash-nightly-20260804-aa90dbc0.zip",
      verified: "github.com/aymericbeaumet/flash/"
  name "Flash"
  desc "Headless hint overlay for macOS"
  homepage "https://github.com/aymericbeaumet/flash"

  depends_on macos: ">= :sonoma"

  app "Flash.app"
  binary "#{appdir}/Flash.app/Contents/MacOS/flash", target: "flash"

  postflight do
    launch_agent = File.expand_path("~/Library/LaunchAgents/com.flash.app.autolaunch.plist")
    system_command "/bin/mkdir", args: ["-p", File.dirname(launch_agent)]
    File.write(launch_agent, <<~PLIST)
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>Label</key>
          <string>com.flash.app.autolaunch</string>
          <key>ProgramArguments</key>
          <array>
              <string>/usr/bin/open</string>
              <string>-g</string>
              <string>/Applications/Flash.app</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
      </dict>
      </plist>
    PLIST
    system_command "/bin/chmod", args: ["644", launch_agent]
    system_command "/bin/launchctl",
                   args: ["bootout", "gui/#{Process.uid}", launch_agent],
                   must_succeed: false
    system_command "/bin/launchctl",
                   args: ["bootstrap", "gui/#{Process.uid}", launch_agent],
                   must_succeed: false
    system_command "/bin/launchctl",
                   args: ["enable", "gui/#{Process.uid}/com.flash.app.autolaunch"],
                   must_succeed: false
    system_command "/usr/bin/open",
                   args: ["-g", "/Applications/Flash.app"],
                   must_succeed: false
  end

  uninstall launchctl: "com.flash.app.autolaunch",
            quit: "com.flash.app",
            delete: "~/Library/LaunchAgents/com.flash.app.autolaunch.plist"

  zap trash: [
    "~/Library/Logs/Flash",
    "~/.config/flash",
  ]
end
