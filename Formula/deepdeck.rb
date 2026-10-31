class Deepdeck < Formula
  desc "A terminal task board for people running several AI coding agents at once."
  homepage "https://github.com/deeplabua/deepdeck"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/deepdeck/releases/download/v0.2.0/deepdeck-aarch64-apple-darwin.tar.xz"
      sha256 "55f2daa4fc6c3e4615fc901f9ae0779abba57277aefb3af51613b436000c7966"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/deepdeck/releases/download/v0.2.0/deepdeck-x86_64-apple-darwin.tar.xz"
      sha256 "4f967cf4cb9944b6dbd98cb1b8e897db11188926909ed5e871ce296ae4d6d146"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/deeplabua/deepdeck/releases/download/v0.2.0/deepdeck-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "a355d0691bd64699bd984aeae8d21f87e4b5db627045a761641e1689b2b8da46"
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
