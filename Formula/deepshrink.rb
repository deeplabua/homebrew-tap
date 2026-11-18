class Deepshrink < Formula
  desc "Shrink media to a target size with one command. Local, private, no watermarks."
  homepage "https://deeplab.tools/products/deepshrink/"
  version "0.3.16"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.16/deepshrink-aarch64-apple-darwin.tar.xz"
      sha256 "e783d41248c89be47f1a968e579ca3c50ef026d4bf9babf101d2c4990faf7816"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.16/deepshrink-x86_64-apple-darwin.tar.xz"
      sha256 "7548a65b8258df12c95e275c7e4e050a1e75c918ff9c12c879bbfe29566a0cfe"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.16/deepshrink-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "de8b0dd1bb4247befa5d5615a382be22184f52cebbe51dfe425d1149e9bd078b"
  end
  license any_of: ["MIT", "Apache-2.0"]
  depends_on "ffmpeg"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
      bin.install "deepshrink"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "deepshrink"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "deepshrink"
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
