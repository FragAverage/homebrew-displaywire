cask "displaywire" do
  version "0.7.0"
  sha256 "8d0dc677c44b10aa35ce5c0f5e25d18d248cb1f3c396ae305d8f1520c0d1a38a"

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
