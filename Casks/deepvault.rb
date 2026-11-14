cask "deepvault" do
  version "1.2"
  sha256 "c242e7206f5e658d78fafebb5641305d078a6ca7e2c368c8d7d88cec492b23f3"

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
