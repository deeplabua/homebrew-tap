class OciArmCatcher < Formula
  desc "Grab Oracle Cloud's free ARM (A1.Flex) capacity the moment it appears — one binary, no OCI CLI"
  homepage "https://deeplab.tools"
  version "0.1.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.9/oci-arm-catcher-aarch64-apple-darwin.tar.xz"
      sha256 "b71fac08ac5b9c7b6e77150c068792e56717b63d9548dfeab0f6b429be06c03b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.9/oci-arm-catcher-x86_64-apple-darwin.tar.xz"
      sha256 "278876c622909008d96659e28006a1627e651a9e076fb5b8b765f890961eac38"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.9/oci-arm-catcher-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cd15f20d793be3aaffb90e410adc10cff8ac25b992fb1042a6bc965eccedd2f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-arm-catcher/releases/download/v0.1.9/oci-arm-catcher-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "500ab7dddc9154009f19e9eab9deb186c420f3ed020c0874bcee6d6cf578eafd"
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
