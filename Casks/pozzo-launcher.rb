# Generato da tools/package_manifests.py nel workflow di release: le modifiche vanno fatte li'.
cask "pozzo-launcher" do
  arch arm: "arm64", intel: "x64"

  version "0.21.2"
  sha256 arm:   "3d68d1113145037b9eb52f5e3bf21410f0bee1a2ae566ca95b1ec5172fde8862",
         intel: "ee8a65af3145585893f78a89d2716fc474d8f8c9ceb36585aa11626e76a9fc86"

  url "https://github.com/pozzo-dev/Pozzo-Launcher/releases/download/v#{version}/PozzoLauncher-#{version}-macos-#{arch}.dmg"
  name "Pozzo Launcher"
  desc "Game library for ROMs and PC games from the stores, with covers and metadata"
  homepage "https://github.com/pozzo-dev/Pozzo-Launcher"

  livecheck do
    url :url
    strategy :github_latest
  end

  # l'app si aggiorna da sola (Impostazioni > Info): brew non la riporta indietro
  auto_updates true
  depends_on macos: ">= :big_sur"

  app "PozzoLauncher.app"

  # firma ad-hoc, non notarizzata: senza togliere la quarantena macOS la dice «danneggiata»
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/PozzoLauncher.app"]
  end
end
