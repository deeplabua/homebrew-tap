cask "deepsnap" do
  version "0.9.1"
  sha256 "e4c0c861d4b4492834771aa58e31d28391aa5d2d9b36b4da7a84ce858f5cd439"

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
