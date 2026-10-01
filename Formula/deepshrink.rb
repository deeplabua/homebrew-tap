class Deepshrink < Formula
  desc "Shrink media to a target size with one command. Local, private, no watermarks."
  homepage "https://deepshrink.tools"
  version "0.3.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.12/deepshrink-aarch64-apple-darwin.tar.xz"
      sha256 "88f0ea805e325af7e48000d06945878272218501621f9f92ae27cd5dc7594dbf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.12/deepshrink-x86_64-apple-darwin.tar.xz"
      sha256 "267f73c401fc268ed3ede41eb30bd59bc8a7ef35995d4a113b078bab4ccd34c2"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.12/deepshrink-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "2bb2875d542ecc529b5760aa68b9fd877376279b067e5528f69f9397f5b5deba"
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
