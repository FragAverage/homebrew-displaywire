cask "displaywire" do
  version "0.6.2"
  sha256 "87b367f16c628f5f476558a0af5f767a00a722581057f4f2243e74593214e8c3"

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
  depends_on macos: ">= :monterey"

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
