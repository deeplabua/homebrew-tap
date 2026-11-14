class DeepvaultCli < Formula
  desc "dv: run commands with secrets from DeepVault, after Touch ID"
  homepage "https://deeplab.tools/products/deepvault/"
  url "https://github.com/deeplabua/deepvault-desktop-releases/releases/download/v1.1/deepvault-cli-1.1.zip"
  sha256 "9013fdb8771d0533cec4bb8b27f2c30b5a108efd67ab41e6ba3930814e4cbfe4"
  license :cannot_represent

  depends_on macos: :sonoma

  def install
    bin.install "deepvault"
    bin.install_symlink "deepvault" => "dv"
  end

  def caveats
    <<~EOS
      dv talks to the DeepVault app (from the Mac App Store or deeplab.tools); it must be running.
      The DeepVault cask already installs dv: use this formula only with the App Store version.
    EOS
  end

  test do
    assert_match "deepvault", shell_output("#{bin}/dv --version")
  end
end
