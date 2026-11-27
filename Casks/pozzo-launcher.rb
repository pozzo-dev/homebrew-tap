# Generato da tools/package_manifests.py nel workflow di release: le modifiche vanno fatte li'.
cask "pozzo-launcher" do
  arch arm: "arm64", intel: "x64"

  version "0.21.1"
  sha256 arm:   "b0cc71040eaf2e66bdbf9c80d81b0417f1d1c0ec6ef8c4e9a8b55f5527094480",
         intel: "400d7b3730dfc62e9814bb175a4cde8f0a171960c23f32c2fce3eee8eaa6b70e"

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
