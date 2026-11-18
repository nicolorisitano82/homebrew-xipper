# Xipper for Homebrew

Archiver for ZIP, 7z, tar, RAR and XIZ, with encryption, signatures and repair:
[nicolorisitano82/xipper](https://github.com/nicolorisitano82/xipper). macOS 26 or later, Apple Silicon.

Homebrew loads formulae and casks of other taps only once you trust them:

```sh
brew trust nicolorisitano82/xipper
```

## The command-line tool, built from source

```sh
brew install nicolorisitano82/xipper/xipper
```

Needs Xcode 26 or later to build (about two minutes). Updates come with `brew upgrade`.

## The app

```sh
brew install --cask nicolorisitano82/xipper/xipper
```

Xipper is signed with its author's own certificate, not an Apple Developer ID, so it is not in
Homebrew's main repository and macOS blocks its first launch: open it once from System Settings >
Privacy & Security > "Open Anyway", or remove the quarantine after checking the download:

```sh
xattr -dr com.apple.quarantine /Applications/Xipper.app
```

The app already contains the command-line tool and offers to link it on its first launch: install
the formula only if you want the tool without the app, or built from source.

---

**Italiano.** Prima `brew trust nicolorisitano82/xipper`. La CLI dai sorgenti:
`brew install nicolorisitano82/xipper/xipper`. L'app: `brew install --cask nicolorisitano82/xipper/xipper`; al
primo avvio serve «Apri comunque» (Impostazioni di Sistema › Privacy e sicurezza), perché l'app non
è firmata con un Developer ID Apple.

MIT License.
