class DeepvaultCli < Formula
  desc "dv: run commands with secrets from DeepVault, after Touch ID"
  homepage "https://deeplab.tools/products/deepvault/"
  url "https://github.com/deeplabua/deepvault-desktop-releases/releases/download/v1.2/deepvault-cli-1.2.zip"
  sha256 "12194b909a2958d2b12c70053f055ec93be479e6ff639d8534953de64b3fcee2"
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
