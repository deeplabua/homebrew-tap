cask "deepshrink" do
  version "0.3.2"
  sha256 "270c34816dd8d64255848789caecb2d7e304d6d79f084625e025fc315c3856b6"

  url "https://github.com/deeplabua/deepshrink-desktop-releases/releases/download/v#{version}/deepshrink_#{version}_universal.dmg"
  name "DeepShrink"
  desc "Compress media to a target size, locally"
  homepage "https://deeplab.tools/products/deepshrink/"

  # The app updates itself via the built-in Tauri updater, so Homebrew should not
  # try to bump it from the tap on every `brew upgrade`.
  auto_updates true
  depends_on macos: :ventura

  app "DeepShrink.app"

  zap trash: [
    "~/Library/Application Support/tools.deeplab.deepshrink",
    "~/Library/Caches/tools.deeplab.deepshrink",
    "~/Library/Preferences/tools.deeplab.deepshrink.plist",
    "~/Library/Saved Application State/tools.deeplab.deepshrink.savedState",
  ]
end
