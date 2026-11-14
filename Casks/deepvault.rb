cask "deepvault" do
  version "1.1"
  sha256 "223b9678ab80bc12db51f5b0f422f14d86b152ee9956db0ef1fc6155ff9255e8"

  url "https://github.com/deeplabua/deepvault-desktop-releases/releases/download/v#{version}/DeepVault-#{version}.dmg"
  name "DeepVault"
  desc "Local password and secrets manager with an SSH agent and dv CLI"
  homepage "https://deeplab.tools/products/deepvault/"

  # Sparkle inside the app installs new versions; the release CI bumps this cask too.
  auto_updates true
  depends_on macos: :sonoma

  app "DeepVault.app"
  binary "#{appdir}/DeepVault.app/Contents/Helpers/deepvault"
  binary "#{appdir}/DeepVault.app/Contents/Helpers/deepvault", target: "dv"

  # No zap of ~/Library/Containers/tools.deeplab.deepvault on purpose: the vaults live there,
  # and uninstalling a password manager must never delete them.
end
