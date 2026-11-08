cask "kubby-beta" do
  version "2.0.0-beta.2"
  sha256 "e26ed7ca36cafaf6d96413643dc47d521ccbf1aa2b8f3f8a883c40b0c38459c4"

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
