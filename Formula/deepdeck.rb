class Deepdeck < Formula
  desc "A terminal task board for people running several AI coding agents at once."
  homepage "https://github.com/deeplabua/deepdeck"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/deepdeck/releases/download/v0.5.0/deepdeck-aarch64-apple-darwin.tar.xz"
      sha256 "52930f26b1d2039b38e117522034eb6c268e4fd0424bbccddb401e1066a98073"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/deepdeck/releases/download/v0.5.0/deepdeck-x86_64-apple-darwin.tar.xz"
      sha256 "6528c99f317804aed86cbeaee9615138bcf18e865223d8f1bbd5fe91beaf53d6"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/deeplabua/deepdeck/releases/download/v0.5.0/deepdeck-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "b64cc064b1a5327abf62136af4c4162f8cc181bcf0c00865913aa43f8b78f41f"
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
