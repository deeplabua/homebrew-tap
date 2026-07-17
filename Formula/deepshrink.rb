class Deepshrink < Formula
  desc "Shrink media to a target size with one command. Local, private, no watermarks."
  homepage "https://deepshrink.tools"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.0/deepshrink-aarch64-apple-darwin.tar.xz"
      sha256 "ddbf4ace34f64c1a58ac7b1844ebae3ad36f8160bc5a23460340a2cb92818c5e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.0/deepshrink-x86_64-apple-darwin.tar.xz"
      sha256 "af47f5665beee45715ec61707d52c55a0476b5940888a71cdfc8634c745968c7"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.0/deepshrink-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "39632efb07ad28d1e7e898bb16aa5e0b29fcc4d5c682bc4e449df6ead8e169e4"
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
