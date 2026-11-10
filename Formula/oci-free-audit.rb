class OciFreeAudit < Formula
  desc "Will Oracle charge me? A read-only check of your OCI tenancy against the Always Free limits and your actual bill"
  homepage "https://deeplab.tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.1.0/oci-free-audit-aarch64-apple-darwin.tar.xz"
      sha256 "e4b63c2e323ca239fcba0994b679ea7cdaa4aa6bfaadd2142b29ecafebaf7d1d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.1.0/oci-free-audit-x86_64-apple-darwin.tar.xz"
      sha256 "f95408b5e1ba4ab8b593f088f6ade1d4e89b77c5bb57ed79dea0413c4de04a1c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.1.0/oci-free-audit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7fd18603dad823d8c6ab47bb04b1102a352130e3a62729c9010d20b83d129dc5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.1.0/oci-free-audit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "46b831c0e3fb0a4bd0745d50527138be3a106cc8974b4195e37665c6b52c170a"
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
