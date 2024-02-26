{ pkgs, ... }: 
let
  on_flatpaks = [
    "org.telegram.desktop"
    "info.smplayer.SMPlayer"
    "org.atheme.audacious"
    "org.standardnotes.standardnotes"
    "org.qbittorrent.qBittorrent"
    "org.gnome.SimpleScan"
    "org.gnome.gThumb"
    "org.libreoffice.LibreOffice"
    "org.gnome.Boxes"
    "io.gitlab.librewolf-community"
    "com.vscodium.codium"
    "org.gnome.Mines"
    "com.valvesoftware.Steam"
    "com.usebottles.bottles"
  ];
in {
  services.flatpak = {
    enable = stdenv.isLinux;
    packages = on_flatpaks;
  };
}
