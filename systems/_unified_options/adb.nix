{ config, pkgs, ... }: {
  # Enable Wireshark if using NixOS
  programs.adb = {
    enable = pkgs.stdenv.isLinux;
  };

  # Install as separate package if using macOS
  environment.systemPackages = if pkgs.stdenv.isDarwin then [
    pkgs.android-tools
  ] else [ ];
}