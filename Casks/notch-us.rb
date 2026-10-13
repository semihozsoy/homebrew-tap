cask "notch-us" do
  version "1.3.0"
  sha256 "a33f4b17f332a10118f025291dbc26d5240089b7c41b4368590613abece1d8be"

  url "https://github.com/semihozsoy/notch-us/releases/download/v#{version}/NotchUs.zip"
  name "Notch Us"
  desc "Shows Claude Code usage limits in the menu bar and around the notch"
  homepage "https://github.com/semihozsoy/notch-us"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app checks for and installs its own updates.
  auto_updates true
  depends_on macos: :sonoma

  app "NotchUs.app"

  # The app is ad-hoc signed, not notarized; without this Gatekeeper refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/NotchUs.app"]
  end

  uninstall quit: "dev.semihozsoy.notchus"

  zap trash: "~/Library/Preferences/dev.semihozsoy.notchus.plist"
end
