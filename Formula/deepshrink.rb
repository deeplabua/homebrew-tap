class Deepshrink < Formula
  desc "Shrink media to a target size with one command. Local, private, no watermarks."
  homepage "https://deepshrink.tools"
  version "0.3.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.7/deepshrink-aarch64-apple-darwin.tar.xz"
      sha256 "663026ae67441c376e0bc618e969aecb105ad89054a6e99cec764e74b2d1c7b7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.7/deepshrink-x86_64-apple-darwin.tar.xz"
      sha256 "b8af7bbf62951fb1be52f2ad4e589a75d5c75e93066bed40299e88a9572f7779"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/deeplabua/deepshrink/releases/download/v0.3.7/deepshrink-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c2474ebeb72d4530870cb53dbf33eb5275c6243bcad2d2641d28d201631bf6f6"
  end
  license any_of: ["MIT", "Apache-2.0"]
  depends_on "ffmpeg"

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "deepshrink"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "deepshrink"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "deepshrink"
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
