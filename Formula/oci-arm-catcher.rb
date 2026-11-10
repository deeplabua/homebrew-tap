class OciArmCatcher < Formula
  desc "Grab Oracle Cloud's free ARM (A1.Flex) capacity the moment it appears — one binary, no OCI CLI"
  homepage "https://deeplab.tools"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.8/oci-arm-catcher-aarch64-apple-darwin.tar.xz"
      sha256 "1b24f375140a9906654c4e7253262591319d3c8c201d0bb922ba1f04bc1baca9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.8/oci-arm-catcher-x86_64-apple-darwin.tar.xz"
      sha256 "d8f466389c3658f5aeb2641575a143b1998ab59e773a13d12b63ed76b543bf8c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.8/oci-arm-catcher-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "580346889e03796ff895cd42b9f2e54ee83336cbad612594ea30ffb38803c3b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.8/oci-arm-catcher-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0487c79c0db3470dcde05f69c1c9541ffb62441a5562c8fac07c6cc7882dd1bc"
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
