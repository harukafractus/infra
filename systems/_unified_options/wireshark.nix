{ config, pkgs, ... }: {
  # Enable Wireshark if using NixOS
  programs.wireshark = {
    enable = pkgs.stdenv.isLinux;
    package = pkgs.wireshark;
  };

  # Install as separate package if using macOS
  environment.systemPackages = if pkgs.stdenv.isDarwin then [
    pkgs.android-tools
  ] else [ ];
}