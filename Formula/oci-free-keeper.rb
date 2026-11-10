class OciFreeKeeper < Formula
  desc "Keep your Oracle Cloud Always Free instances from being reclaimed as idle — know how close they are, before Oracle does"
  homepage "https://deeplab.tools"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.1.1/oci-free-keeper-aarch64-apple-darwin.tar.xz"
      sha256 "faffad3e1209f18d019c2d57014166569e86283398f3fbb6364fbd12a40a3dd1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.1.1/oci-free-keeper-x86_64-apple-darwin.tar.xz"
      sha256 "03294063f876335d3092fcedf679d3a7a3e9b26267a8ccf7bf1fa6992f12c1c3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.1.1/oci-free-keeper-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5bab09d0b2fd92c2759c197420bf5e3d2ed1105653f3d9786e5debfcfb44dfca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.1.1/oci-free-keeper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "16f69e9f94aa9f38f23ddd86e5a97c0b3022bde248010c2125c573ba1d3beb26"
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
