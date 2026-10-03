cask "deepshrink" do
  version "0.3.0"
  sha256 "e176d31678d765c8b7b1835c1c4c371bd3817db15a88fb105b0f404701a6ebe5"

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
