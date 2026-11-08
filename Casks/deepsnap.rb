cask "deepsnap" do
  version "0.9.5"
  sha256 "88c9426818e2bf911f7cb4d0c6b28ce08351c000c961de55fced1ef899c47b06"

  url "https://github.com/deeplabua/deepsnap-releases/releases/download/v#{version}/DeepSnap-#{version}.dmg"
  name "DeepSnap"
  desc "Screenshots and screen recordings with text search, secret hiding and GIFs"
  homepage "https://deeplab.tools/products/deepsnap/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # DeepSnap updates itself with Sparkle.
  auto_updates true
  depends_on macos: :sonoma

  app "DeepSnap.app"

  zap trash: [
    "~/Library/Application Support/DeepSnap",
    "~/Library/Caches/tools.deeplab.deepsnap",
    "~/Library/HTTPStorages/tools.deeplab.deepsnap",
    "~/Library/Preferences/tools.deeplab.deepsnap.plist",
    "~/Library/Saved Application State/tools.deeplab.deepsnap.savedState",
  ]
end
