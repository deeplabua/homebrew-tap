cask "deepvault" do
  version "0.1.0"
  sha256 "7ee890932970eed0dfb3513c40227e203519585baad123fabf9759b07745ae72"

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
