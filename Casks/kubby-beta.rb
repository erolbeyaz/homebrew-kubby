cask "kubby-beta" do
  version "2.0.0-beta.1"
  sha256 "ec4937413bb1f481fb70db02f21e803440f5663f9d6549ef683e9da9cd8cc004"

  url "https://github.com/erolbeyaz/homebrew-kubby/releases/download/v#{version}/Kubby_#{version}_aarch64.dmg"
  name "Kubby (beta)"
  desc "Kubernetes desktop for DevOps teams"
  homepage "https://kubby.tech"

  livecheck do
    url :url
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+-beta\.\d+)$/i)
  end

  auto_updates false
  conflicts_with cask: "kubby"
  depends_on arch: :arm64
  depends_on macos: ">= :ventura"
  depends_on formula: ["kubernetes-cli", "helm"]

  app "Kubby.app"

  zap trash: [
    "~/Library/Application Support/Kubby",
    "~/Library/Application Support/tech.kubby.desktop",
    "~/Library/Caches/tech.kubby.desktop",
    "~/Library/LaunchAgents/tech.kubby.desktop.plist",
    "~/Library/HTTPStorages/tech.kubby.desktop",
    "~/Library/Logs/tech.kubby.desktop",
    "~/Library/Preferences/tech.kubby.desktop.plist",
    "~/Library/Saved Application State/tech.kubby.desktop.savedState",
    "~/Library/WebKit/tech.kubby.desktop",
  ]

  caveats <<~EOS
    Kubby is not notarized by Apple yet. Either install with
      brew install --cask --no-quarantine kubby-beta
    or, after the first launch is blocked, open System Settings › Privacy & Security
    and choose "Open Anyway". macOS may ask once for Keychain access after an update.
  EOS
end
