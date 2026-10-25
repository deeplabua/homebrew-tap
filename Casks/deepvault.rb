cask "deepvault" do
  version "0.1.2"
  sha256 "1583d414a3d07aaeb8911ccd41f67f26e214932312ebd92c3c957ca16d761dfd"

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
