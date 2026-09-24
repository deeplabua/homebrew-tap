cask "deepshrink" do
  version "0.1.0"
  sha256 "1192445e348576b00ba008d59a9a23ac039cef910769a8dec7dbbd7f9f462207"

  url "https://github.com/deeplabua/deepshrink-desktop-releases/releases/download/v#{version}/deepshrink_#{version}_universal.dmg"
  name "DeepShrink"
  desc "Compress media to a target size, locally"
  homepage "https://deepshrink.tools"

  # The app updates itself via the built-in Tauri updater, so Homebrew should not
  # try to bump it from the tap on every `brew upgrade`.
  auto_updates true
  depends_on macos: ">= :ventura"

  app "DeepShrink.app"

  zap trash: [
    "~/Library/Application Support/tools.deeplab.deepshrink",
    "~/Library/Caches/tools.deeplab.deepshrink",
    "~/Library/Preferences/tools.deeplab.deepshrink.plist",
    "~/Library/Saved Application State/tools.deeplab.deepshrink.savedState",
  ]
end
