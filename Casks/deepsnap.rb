cask "deepsnap" do
  version "0.8.9"
  sha256 "0406b35b12123e8dc33d99ade945680e793b7425d3f2c4bacb9b5693ab12f0be"

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
