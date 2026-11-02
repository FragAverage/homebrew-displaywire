cask "displaywire" do
  version "0.6.3"
  sha256 "513a0da0c4d73e9add48cd2d603352084d25bb8cf9a868bc8cd3c518259c8457"

  url "https://github.com/FragAverage/displaywire/releases/download/v#{version}/DisplayWire-macos.zip"
  name "DisplayWire"
  desc "Low-latency desktop streaming from a Windows PC"
  homepage "https://github.com/FragAverage/displaywire"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself (Check for Updates), so `brew upgrade` leaves it alone.
  auto_updates true
  depends_on macos: :monterey

  app "DisplayWire.app"

  # The app is not notarized, so macOS would otherwise refuse to open the download.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/DisplayWire.app"]
  end

  zap trash: [
    "~/Library/Application Support/DisplayWire",
    "~/Library/Preferences/app.displaywire.client.plist",
  ]
end
