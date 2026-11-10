class OciFreeAudit < Formula
  desc "Will Oracle charge me? A read-only check of your OCI tenancy against the Always Free limits and your actual bill"
  homepage "https://deeplab.tools"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.2.0/oci-free-audit-aarch64-apple-darwin.tar.xz"
      sha256 "ed167451ddac2c5db297fc9734ab784bfa9124200f8e09e9739b5472b86b9be6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.2.0/oci-free-audit-x86_64-apple-darwin.tar.xz"
      sha256 "2b8851d3c0deb9869c07237f7c0838a37382dc2324a05ce21fc644c23ec3a0f3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.2.0/oci-free-audit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "996fdb183b499deebae44e5a92428e836768a764d68e84d23ca8014ec5248deb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.2.0/oci-free-audit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3031cba7e6c10f850af19af61f37f4d81126af174dd1842cb6220d12dce1eedc"
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
