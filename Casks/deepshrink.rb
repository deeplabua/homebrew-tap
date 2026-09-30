cask "deepshrink" do
  version "0.2.2"
  sha256 "4cf014b58387dced86b10e10fe07aff8ed6932f4691b9ceb39c7bfb92ef10ad6"

  url "https://github.com/deeplabua/deepshrink-desktop-releases/releases/download/v#{version}/deepshrink_#{version}_universal.dmg"
  name "DeepShrink"
  desc "Compress media to a target size, locally"
  homepage "https://deepshrink.tools"

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
