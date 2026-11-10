class OciFreeKeeper < Formula
  desc "Keep your Oracle Cloud Always Free instances from being reclaimed as idle — know how close they are, before Oracle does"
  homepage "https://deeplab.tools"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.1.2/oci-free-keeper-aarch64-apple-darwin.tar.xz"
      sha256 "cbabe39c91a64a45a873c336462ad457a287bbaa2d7bfd028eeb2e5e3eb139cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.1.2/oci-free-keeper-x86_64-apple-darwin.tar.xz"
      sha256 "4acb4d2a6c03d02a90969c63c7c191da13ddfd2de18a9f40a7fd99f7a8cb5085"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.1.2/oci-free-keeper-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7ac9bb65562ec7fc4f51ce89ab278641fc80a65c2af6888bf7b835e64c530770"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.1.2/oci-free-keeper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5db62fe35f140bbf6760ad6323141c9bb8fd2effea0c20f493cd9c18108f461a"
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
      bin.install "oci-free-keeper"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "oci-free-keeper"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "oci-free-keeper"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "oci-free-keeper"
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
