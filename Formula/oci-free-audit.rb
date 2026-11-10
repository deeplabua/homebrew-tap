class OciFreeAudit < Formula
  desc "Will Oracle charge me? A read-only check of your OCI tenancy against the Always Free limits and your actual bill"
  homepage "https://deeplab.tools"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.2.1/oci-free-audit-aarch64-apple-darwin.tar.xz"
      sha256 "a00da2326fca7c615c04c175f639dadf064ac5f7678621d1cf9b859e2a1f44c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.2.1/oci-free-audit-x86_64-apple-darwin.tar.xz"
      sha256 "232c786822e8e81a628b68b310567075440aa2c15a96441344388c403bd7ec07"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.2.1/oci-free-audit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "261a20acbc993bb51b8e4cc34753edfa0f6edab9394aaef114f691715876e2bf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.2.1/oci-free-audit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5c02b16a3596c52daf35f23f6daf0d827215efed0838dd516ed5f975c671e925"
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
      bin.install "oci-free-audit"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "oci-free-audit"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "oci-free-audit"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "oci-free-audit"
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
