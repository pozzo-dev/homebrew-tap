# Generato da tools/package_manifests.py nel workflow di release: le modifiche vanno fatte li'.
cask "pozzo-launcher" do
  arch arm: "arm64", intel: "x64"

  version "0.20.2"
  sha256 arm:   "54078e2bcd441c289726a78465326d1cfd3cff7c3d42b5625df863b6720e2f4c",
         intel: "81735e035b3a1b3d05ba786e5d122421eb995ede27f26d4677ce5a5f45631ab8"

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
