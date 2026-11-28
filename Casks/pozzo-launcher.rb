# Generato da tools/package_manifests.py nel workflow di release: le modifiche vanno fatte li'.
cask "pozzo-launcher" do
  arch arm: "arm64", intel: "x64"

  version "0.21.3"
  sha256 arm:   "2d305f750936b9d3ce86a87cc980b6c7e2363b17db2cd02510955fad92cbd8ae",
         intel: "796429bfea0b63f5af69c406e574e45ac0afbf49db9b30634f96c8dc9f1afd16"

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
