class Xipper < Formula
  desc "Archiver for ZIP, 7z, tar, RAR and XIZ, with encryption, signatures and repair"
  homepage "https://github.com/nicolorisitano82/xipper"
  url "https://github.com/nicolorisitano82/xipper/archive/refs/tags/v3.5.1.tar.gz"
  sha256 "51bde723d2d71cc40669ad3e3be8062aa78eed17995d2bd6371fdc6a43befbae"
  license "MIT"
  head "https://github.com/nicolorisitano82/xipper.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on xcode: ["26.0", :build]
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "xipper"
    # xipper looks for its Diceware word lists in ../Resources/Wordlists next to the real executable.
    (libexec/"bin").install ".build/release/xipper"
    (libexec/"Resources/Wordlists").install Dir["Vendor/wordlists/*.txt"]
    bin.install_symlink libexec/"bin/xipper"
    doc.install Dir["user-manual/*.md"]
  end

  def caveats
    <<~EOS
      The Xipper app (brew install --cask nicolorisitano82/xipper/xipper) has the same command
      inside it; if the app already linked #{HOMEBREW_PREFIX}/bin/xipper, this formula stays unlinked
      until you remove that link: brew link --overwrite xipper
    EOS
  end

  test do
    (testpath/"in/hello.txt").write "ciao\n"
    system bin/"xipper", "create", testpath/"a.xiz", testpath/"in"
    system bin/"xipper", "test", testpath/"a.xiz"
    (testpath/"out").mkpath
    system bin/"xipper", "extract", "-d", testpath/"out", "--into", testpath/"a.xiz"
    assert_equal "ciao\n", (testpath/"out/in/hello.txt").read
    assert_match version.to_s, shell_output("#{bin}/xipper --version")
    assert_match(/\w+-\w+-\w+/, shell_output("#{bin}/xipper passphrase"))
  end
end
