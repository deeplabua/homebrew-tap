class OciArmCatcher < Formula
  desc "Grab Oracle Cloud's free ARM (A1.Flex) capacity the moment it appears — one binary, no OCI CLI"
  homepage "https://deeplab.tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.0/oci-arm-catcher-aarch64-apple-darwin.tar.xz"
      sha256 "7fbff34b3dac1d8b8e90f39c38c57deffb3babbf14866696c20ab5417a2b3e89"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.0/oci-arm-catcher-x86_64-apple-darwin.tar.xz"
      sha256 "0e4a01ff1b03841b9f87ba7f081c3f2f4c42a1218d7397a7289cd7af25f82c7f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.0/oci-arm-catcher-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "37e34bd03503e1430ef0f0450fca4a741e8e879f6e31fa5061e7021aa32d561b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.0/oci-arm-catcher-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "25b2adfdf551e8b263afb6331ead2523fdd58851160c902c5f403c7debce271d"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "oci-arm-catcher"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "oci-arm-catcher"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "oci-arm-catcher"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "oci-arm-catcher"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
