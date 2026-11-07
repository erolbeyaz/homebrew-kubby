# Homebrew tap for Kubby (macOS)

This text doubles as the README of the public tap repository `erolbeyaz/homebrew-kubby`. The tap holds
two casks and the release assets; everything in it is written by the `release.yml` workflow of the
(private) `kubby-mac` repository.

## Install

Beta (testers):

```
brew install --cask --no-quarantine erolbeyaz/kubby/kubby-beta
```

Stable (from 2.0.0):

```
brew install --cask --no-quarantine erolbeyaz/kubby/kubby
```

Upgrade: `brew upgrade --cask kubby-beta` (or `kubby`). Uninstall and remove settings:
`brew uninstall --zap --cask kubby-beta`.

`--no-quarantine` skips the Gatekeeper block that unsigned apps get on first launch. Without it, open
System Settings › Privacy & Security after the first attempt and choose **Open Anyway**. Kubby needs
`kubectl` and `helm` for its terminal and Helm views; Homebrew installs them as dependencies.

## Layout of the tap repository

```
homebrew-kubby/
  README.md          this file
  Casks/
    kubby-beta.rb    prereleases (tags v*-beta.N), written by the workflow
    kubby.rb         releases (tags vX.Y.Z), written by the workflow
  Releases (GitHub): Kubby_<version>_universal.dmg, SHA256SUMS.txt, smoke-<version>.png
```

## How a release gets here

1. In `kubby-mac`, the version in `package.json` and `src-tauri/tauri.conf.json` is bumped and a tag
   `v<version>` is pushed.
2. `release.yml` builds the universal app on a macOS runner, checks the ad-hoc signature, launches the
   app once and takes a screenshot, computes the SHA-256, creates the GitHub Release **in this
   repository** (prerelease when the version has a `-`), regenerates the cask with
   `scripts/cask-update.mjs` and pushes it to `Casks/`.
3. Testers run `brew upgrade --cask kubby-beta`.

The workflow authenticates with the repository secret `TAP_TOKEN` (fine-grained token, Contents: read
and write on this repository only).

## Maintainer notes

- Regenerate a cask by hand (for example after editing the template in `scripts/cask-update.mjs`):
  `node scripts/cask-update.mjs --version 2.0.0-beta.1 --sha256 <hex> --tag v2.0.0-beta.1 --repo erolbeyaz/homebrew-kubby --cask kubby-beta > Casks/kubby-beta.rb`
- On a Mac, validate before pushing by hand: `brew style Casks/kubby-beta.rb` and
  `brew audit --cask --online --strict Casks/kubby-beta.rb`; install locally with
  `brew install --cask ./Casks/kubby-beta.rb`.
- When the app is signed and notarized (Phase 6), remove the Gatekeeper caveat and the
  `--no-quarantine` advice from the template and this README.
- `homebrew/cask` (the official repository) is a later step; it has notability requirements and its
  own review. The tap keeps working either way.
