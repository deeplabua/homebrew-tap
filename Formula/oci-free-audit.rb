class OciFreeAudit < Formula
  desc "Will Oracle charge me? A read-only check of your OCI tenancy against the Always Free limits and your actual bill"
  homepage "https://deeplab.tools"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.5.0/oci-free-audit-aarch64-apple-darwin.tar.xz"
      sha256 "afb44b9de3ab6241901dbb5042aa42254b53894b33faca4a3783f4563176970c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.5.0/oci-free-audit-x86_64-apple-darwin.tar.xz"
      sha256 "e47d5ef77fb72956cb1e1725a2c85c5f1aba75f2c6e60f098938322cd6a55983"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.5.0/oci-free-audit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1cff1c95857d16ade94b74baf77dbfe433fd84f90d2e7317b0f5f399d173569d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/oci-free-audit/releases/download/v0.5.0/oci-free-audit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "60e19c80ade059b93ca7e94201cf6b421a28006fce43a3e2f8c332d7ee603b40"
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
