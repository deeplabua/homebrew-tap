cask "deepsnap" do
  version "0.7.1"
  sha256 "0d0b1baac0197552ef4efa28c64ce84b80f792e095d5467ffce0f1aacdb61a9d"

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
