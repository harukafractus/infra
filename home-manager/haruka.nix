{ pkgs, config, lib, ... }:
{
  imports = [ ./gnome.nix ./hyprland.nix ];

  home = {
    username = "haruka";
    homeDirectory = "/home/haruka";
    stateVersion = "23.11";
  };

  services.flatpak = {
    enable = true;
    packages = [
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
    ];
  };

  programs.git = {
    enable = true;
     userName = "harukafractus";
     userEmail = "106440141+harukafractus@users.noreply.github.com";
     signing.signByDefault = true;
  };

  programs.home-manager = {
    enable = true;
  };

  programs.htop = {
    enable = true;
  };

  programs.hyfetch = {
    enable = true;
    settings = {
      mode = "rgb";
      preset = "rainbow";
      lightness = 0.6;
      color_align.mode = "horizontal";
      backend = "fastfetch";
    };
  };
}
