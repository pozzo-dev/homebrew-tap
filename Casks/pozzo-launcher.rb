# Generato da tools/package_manifests.py nel workflow di release: le modifiche vanno fatte li'.
cask "pozzo-launcher" do
  arch arm: "arm64", intel: "x64"

  version "0.20.1"
  sha256 arm:   "b2bca34f689ec9a4accaf4d6a09caa778c593398269fbcada1b050895a72392e",
         intel: "9c590478fe9feff52985a0cf7c88ed7dfc2d7072e08626354c4fd6ef7615a67b"

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
