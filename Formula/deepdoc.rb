class Deepdoc < Formula
  desc "Any document to clean Markdown, in one command. Pure Rust, one static binary."
  homepage "https://github.com/deeplabua/deepdoc"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/deepdoc/releases/download/v0.1.0/deepdoc-aarch64-apple-darwin.tar.xz"
      sha256 "954cdf804535c579b5723e058d9ea4b5148ed5b8306ef816eab2424244a5c1b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/deepdoc/releases/download/v0.1.0/deepdoc-x86_64-apple-darwin.tar.xz"
      sha256 "1d0328e57b8a7838431acce5c084ccdb21687b1e2c465ca1cb6880044c6e50db"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/deeplabua/deepdoc/releases/download/v0.1.0/deepdoc-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "516634868a89fc7ad9f367b8e6f262f96e7ed7c236a50075d32d122ccdf04a6e"
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "deepdoc" if OS.mac? && Hardware::CPU.arm?
    bin.install "deepdoc" if OS.mac? && Hardware::CPU.intel?
    bin.install "deepdoc" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
