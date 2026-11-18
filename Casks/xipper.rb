cask "xipper" do
  version "3.5.1"
  sha256 "f35c91b727790894020bfe51a7610182e6708b997fafd3215d4f170b25346c28"

  url "https://github.com/nicolorisitano82/xipper/releases/download/v#{version}/Xipper-#{version}.dmg"
  name "Xipper"
  desc "Archiver for ZIP, 7z, tar, RAR and XIZ, with encryption, signatures and repair"
  homepage "https://github.com/nicolorisitano82/xipper"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Xipper.app"

  zap trash: [
    "~/Library/Containers/app.xipper.Xipper.FinderSync",
    "~/Library/Containers/app.xipper.Xipper.Preview",
    "~/Library/Containers/app.xipper.Xipper.Thumbnail",
    "~/Library/Preferences/app.xipper.Xipper.plist",
  ]

  caveats <<~EOS
    Xipper is signed with its author's own certificate, not an Apple Developer ID: on the first
    launch macOS blocks it. Open it once from System Settings > Privacy & Security > "Open Anyway",
    or, after checking the download, remove the quarantine yourself:
      xattr -dr com.apple.quarantine /Applications/Xipper.app
  EOS
end
