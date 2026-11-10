class OciArmCatcher < Formula
  desc "Grab Oracle Cloud's free ARM (A1.Flex) capacity the moment it appears — one binary, no OCI CLI"
  homepage "https://deeplab.tools"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.6/oci-arm-catcher-aarch64-apple-darwin.tar.xz"
      sha256 "3326812fc6bc1ebdf7bb49f1a24ca788a1615621e92d8ec1d18868b532ee026f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.6/oci-arm-catcher-x86_64-apple-darwin.tar.xz"
      sha256 "e227164d16ae32fcffa36ad7237a69024723f455f73ad87f2cd475dd1a078204"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.6/oci-arm-catcher-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1ac1b1c5f52e735896bc672d0dbcbc95bf08ce161657becf6279bd520358ada2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.6/oci-arm-catcher-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3aa790e0964d16e9817cf3db384c09dedb49546a74d86a36cd020b14cb2ad3e5"
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
