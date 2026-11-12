class Deepdeck < Formula
  desc "A terminal task board for people running several AI coding agents at once."
  homepage "https://github.com/deeplabua/deepdeck"
  version "0.6.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/deepdeck/releases/download/v0.6.2/deepdeck-aarch64-apple-darwin.tar.xz"
      sha256 "6df26dc5bf0e1ef62ba2d1c7b922c49babf47b4b8a7b477b7f0594d46f7f79d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/deepdeck/releases/download/v0.6.2/deepdeck-x86_64-apple-darwin.tar.xz"
      sha256 "d84b9dae9e094e8ec738508670e0bba9c79bfc1ce7c24d6d7ae08b1279f3762a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/deeplabua/deepdeck/releases/download/v0.6.2/deepdeck-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "e1fc04612907036995d1bd864824e1c234fb871db7ab38fc60a206b2ecf455e0"
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
