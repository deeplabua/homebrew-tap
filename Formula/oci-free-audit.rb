class OciFreeAudit < Formula
  desc "Will Oracle charge me? A read-only check of your OCI tenancy against the Always Free limits and your actual bill"
  homepage "https://deeplab.tools"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.4.1/oci-free-audit-aarch64-apple-darwin.tar.xz"
      sha256 "4498afdc942de302e25486d719a034148bee2b76523be3f948a84de5716fca36"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.4.1/oci-free-audit-x86_64-apple-darwin.tar.xz"
      sha256 "8fd39c996ff67a13a4b3386bf2d2fe3e17dd9613c256c05c1fa38334d6873610"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.4.1/oci-free-audit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3fae4da3456c1f524c4f873f72b0b55763a66f9eedf7b2b05d1625392a8904d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.4.1/oci-free-audit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8fe9efb480ed6a8b5e9f63ac8073516e8c4ac61ecff97e199c73b3385b578613"
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
