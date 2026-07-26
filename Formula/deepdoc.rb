class Deepdoc < Formula
  desc "Any document to clean Markdown, in one command. Pure Rust, one static binary."
  homepage "https://github.com/deeplabua/deepdoc"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/deepdoc/releases/download/v0.3.0/deepdoc-aarch64-apple-darwin.tar.xz"
      sha256 "23ccb5a20149fe4fa2563ec35779438ad4846df5ce9276e7e3eb51b64d816cb4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/deepdoc/releases/download/v0.3.0/deepdoc-x86_64-apple-darwin.tar.xz"
      sha256 "4da19e346882c1569a3896a3044bbd0997657d9f9589f19c20d2157fdade150b"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/deeplabua/deepdoc/releases/download/v0.3.0/deepdoc-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "552b7c51efba1ad919e5de0fb5270b4b0962f5a2d39e58bb40ff8ba47a0853b3"
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
