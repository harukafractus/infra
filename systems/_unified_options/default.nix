# impowt evewything
{ config, lib, pkgs, ... }: {
  imports = [
    ./adb.nix
    ./env_pkgs.nix
    ./nixpkgs.nix
    ./wireshark.nix
    ./supportedfs.nix
    ./zsh.nix
  ];
}