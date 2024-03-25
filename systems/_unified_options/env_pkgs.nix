{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    htop
    git
    curl
    coreutils-full
    util-linux
    smartmontools
    pciutils
    bat
    unar
  ] ++ ( if pkgs.stdenv.isLinux then [
    pkgs.usbutils
  ] else [ ] );
}