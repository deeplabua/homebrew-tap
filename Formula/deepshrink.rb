class Deepshrink < Formula
  desc "Shrink media to a target size with one command. Local, private, no watermarks."
  homepage "https://deepshrink.tools"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/deepshrink/releases/download/v0.2.1/deepshrink-aarch64-apple-darwin.tar.xz"
      sha256 "7255560332f5eecab09225ad31657667b863e7805e724db228ec98e98750b623"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/deepshrink/releases/download/v0.2.1/deepshrink-x86_64-apple-darwin.tar.xz"
      sha256 "50547bfcfa3148b3d6257297ad64882da94bdd1737e73daacf71dcd773b7b2cc"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/deeplabua/deepshrink/releases/download/v0.2.1/deepshrink-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "4e369e0b2c8983eddc162d8f29f4ec16f50b51b80da0fbd9abd02194d7a40ac7"
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
