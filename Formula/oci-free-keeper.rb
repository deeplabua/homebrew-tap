class OciFreeKeeper < Formula
  desc "Keep your Oracle Cloud Always Free instances from being reclaimed as idle — know how close they are, before Oracle does"
  homepage "https://deeplab.tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.1.0/oci-free-keeper-aarch64-apple-darwin.tar.xz"
      sha256 "d5ed9c48d9759e63cb22fbdb755cd41353f4970cda430768ef7443a5ee7f5f81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.1.0/oci-free-keeper-x86_64-apple-darwin.tar.xz"
      sha256 "4d74d097497c2262fd185cef2e907b6573a9bfd24e5aeb19c44c5e9fca439893"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.1.0/oci-free-keeper-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7464187dd721272e5f29df447089f8d306a76c4a5a23e5f9d4000ffb9f5c259f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.1.0/oci-free-keeper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a3aa0483232890a8bae244a45e1375bebcad1a7d680b3abff927289026cb3fff"
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
