# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, asahi, ... }: {
  imports = [
    asahi.nixosModules.apple-silicon-support
    ./hardware-configuration.nix
    ../_unified_options
    ../_linux_userland/gdm.nix
    ../_linux_userland/ibus.nix
    ../_linux_userland/gnome.nix
    ../_linux_userland/network-manager.nix
    ../_linux_userland/pipewire_alsa.nix
    ../_linux_userland/zram.nix
    ../_linux_userland/avahi.nix
  ];

  nixpkgs.hostPlatform.system = "aarch64-linux";
  networking.hostName = "haruka-asahi";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  # Remove unnessary packages on the system
  environment.defaultPackages = lib.mkForce [];

  # Enable GPU drivers on nix
  hardware.asahi = {
    withRust = true;
    peripheralFirmwareDirectory = ./fireware_backup; # Just in case
    #extractPeripheralFirmware = false; # Enable / Disable firmware
    useExperimentalGPUDriver = true; # Purity Problem
    experimentalGPUInstallMode = "replace";
  };

  services = {
    thermald.enable = pkgs.system == "x86_64-linux";
    flatpak.enable = true;
    journald.extraConfig = "SystemMaxUse=50M";
    printing.enable = true;
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  system = {
    stateVersion = "unstable";
    # includeBuildDependencies = true;
    # See https://linus.schreibt.jetzt/posts/include-build-dependencies.html#fn1
  };

  nixpkgs.overlays = [ asahi.overlays.apple-silicon-overlay ];
}