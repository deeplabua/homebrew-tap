class Deepshrink < Formula
  desc "Shrink media to a target size with one command. Local, private, no watermarks."
  homepage "https://deepshrink.tools"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.4/deepshrink-aarch64-apple-darwin.tar.xz"
      sha256 "20ec6756f02cd9e07ccd72eee720eb1321662a19b1d786bf320ab2c93bfdf735"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.4/deepshrink-x86_64-apple-darwin.tar.xz"
      sha256 "f26cbcf62b8becfb588433005e0118556e1615c122e67cfa34e49e4efb60aecb"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.4/deepshrink-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "8122d3d9ceea2a4d088425ad6b5ee0dcfa196a3c4812e79a8b5e0775a34a92e1"
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
    bin.install "deepshrink" if OS.mac? && Hardware::CPU.arm?
    bin.install "deepshrink" if OS.mac? && Hardware::CPU.intel?
    bin.install "deepshrink" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
