cask "deepsnap" do
  version "0.8.1"
  sha256 "8a7c7d7f7a4254eb1126dd38219c188c38e516e7b49e2cf8d34c8e4de53059bf"

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
