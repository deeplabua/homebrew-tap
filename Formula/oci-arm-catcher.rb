class OciArmCatcher < Formula
  desc "Grab Oracle Cloud's free ARM (A1.Flex) capacity the moment it appears — one binary, no OCI CLI"
  homepage "https://deeplab.tools"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.7/oci-arm-catcher-aarch64-apple-darwin.tar.xz"
      sha256 "7f0e5f8a43d207f66ec23a16aaabe2ba927f3df08d61d37377a42beb63d456ae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.7/oci-arm-catcher-x86_64-apple-darwin.tar.xz"
      sha256 "dd229f7360524f5ccff91a1930d2b8c9f713bef275dbbb19e4adee9cb4417aef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.7/oci-arm-catcher-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "074a41685315dfe0c3a666052c6b7131c14b9b7aba2d18b548a6f2f9abc4801c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.7/oci-arm-catcher-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7bca039732b2341cf4d25e5f0814f6f8c588495b26b5f4ed559db567fc35ce37"
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
      bin.install "oci-arm-catcher"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "oci-arm-catcher"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "oci-arm-catcher"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "oci-arm-catcher"
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
