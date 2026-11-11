class OciFreeKeeper < Formula
  desc "Keep your Oracle Cloud Always Free instances from being reclaimed as idle — know how close they are, before Oracle does"
  homepage "https://deeplab.tools"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.4.1/oci-free-keeper-aarch64-apple-darwin.tar.xz"
      sha256 "d826f51920fb4a6acee29a475522d37fa9161c895e857c424c0f6914aa459981"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.4.1/oci-free-keeper-x86_64-apple-darwin.tar.xz"
      sha256 "135cc7fb00dfbc1bd3fb4b7fc56ae08d08d1f3ff711f97abaee3112f128cc62b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.4.1/oci-free-keeper-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b330ed24544b898e1943f2e39e70a9d974fb932929abb3dc41a3f919a5b558d8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-keeper/releases/download/v0.4.1/oci-free-keeper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "48948e6e2348d6b986f7ada94bc58194edf90149e47a3fa5f9a4ba4b174fc552"
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
