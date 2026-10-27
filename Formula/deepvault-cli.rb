class DeepvaultCli < Formula
  desc "dv: run commands with secrets from DeepVault, after Touch ID"
  homepage "https://deeplab.tools/products/deepvault/"
  url "https://github.com/deeplabua/deepvault-desktop-releases/releases/download/cli-v0.1.3/deepvault-cli-0.1.3.zip"
  sha256 "07c48356eb287ef3590e2ac47847bf8dfbda2001eb178cbca576acd173889173"
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
