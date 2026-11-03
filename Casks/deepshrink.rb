cask "deepshrink" do
  version "1.0.1"
  sha256 "5a691610e730d9445b621722fb507d008288529bc26f58144e3ebe3e513e0acf"

  url "https://github.com/deeplabua/deepshrink-desktop-releases/releases/download/v#{version}/DeepShrink-#{version}.dmg"
  name "DeepShrink"
  desc "Compress media to a target size, locally"
  homepage "https://deeplab.tools/products/deepshrink/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # DeepShrink updates itself with Sparkle.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "DeepShrink.app"

  zap trash: [
    "~/Library/Application Support/tools.deeplab.deepshrink",
    "~/Library/Caches/tools.deeplab.deepshrink",
    "~/Library/Containers/tools.deeplab.deepshrink",
    "~/Library/HTTPStorages/tools.deeplab.deepshrink",
    "~/Library/Preferences/tools.deeplab.deepshrink.plist",
    "~/Library/Saved Application State/tools.deeplab.deepshrink.savedState",
  ]
end
