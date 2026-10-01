cask "deepshrink" do
  version "0.2.5"
  sha256 "d0f51a845cbd78a16573fb00921f9f9cb2f86e80936e7fd55ab19c8c68b52f51"

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
