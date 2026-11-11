class OciFreeKeeper < Formula
  desc "Keep your Oracle Cloud Always Free instances from being reclaimed as idle — know how close they are, before Oracle does"
  homepage "https://deeplab.tools"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.5.1/oci-free-keeper-aarch64-apple-darwin.tar.xz"
      sha256 "75a2bd4915372709e3b735fe086c357c76898a15f8bb4bf8ccee6e8c75a80664"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.5.1/oci-free-keeper-x86_64-apple-darwin.tar.xz"
      sha256 "1a52768681af52c8729a712c957b527db72ef6d893716575aff1d832ba4364ea"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.5.1/oci-free-keeper-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "97fd173935b3d9793373ef02eb8700d430b47d8d8bff83c5badb64440f6eac01"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.5.1/oci-free-keeper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "031a1a1ce54b8bfd538ec67ef099739a4f97f992cb41cd6847cee85c597f4417"
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
