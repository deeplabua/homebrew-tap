class Deepdeck < Formula
  desc "A terminal task board for people running several AI coding agents at once."
  homepage "https://github.com/deeplabua/deepdeck"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/deepdeck/releases/download/v0.3.2/deepdeck-aarch64-apple-darwin.tar.xz"
      sha256 "737b18a652cb43e78f19a06b631d478490ea4673cfccde269c3ed19e60163581"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/deepdeck/releases/download/v0.3.2/deepdeck-x86_64-apple-darwin.tar.xz"
      sha256 "9f86cc2341ec34ebbd21b7a48ca8f9229004a354e541921ae01d40df3493dc1b"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/deeplabua/deepdeck/releases/download/v0.3.2/deepdeck-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "044091fe9cb9889e3b853881759ec7e6df748ce048e417c7dd7cbd616beb005c"
  end
  license any_of: ["MIT", "Apache-2.0"]

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
      bin.install "ddeck"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ddeck"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ddeck"
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
