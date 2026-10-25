class DeepvaultCli < Formula
  desc "dv: run commands with secrets from DeepVault, after Touch ID"
  homepage "https://deeplab.tools/products/deepvault/"
  url "https://github.com/deeplabua/deepvault-desktop-releases/releases/download/v0.1.2/deepvault-cli-0.1.2.zip"
  sha256 "f6e17e1aecce6d22ba1b459bf71faea11731cb6cf0e31d0fb09434895c34557d"
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
