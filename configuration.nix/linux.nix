{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./desktop
    ../hardware-configuration.nix
  ];

  #virtualisation.waydroid.enable = true;

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
    algorithm = "zstd";
  };
  
  services = {
    thermald.enable = true;
    flatpak.enable = true;
    journald.extraConfig = "SystemMaxUse=50M";
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  programs = {
    less.enable = lib.mkForce false;
    adb.enable = true;
    zsh.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [ 80 443 22 5000 ];
    };
    extraHosts = ''
      ::1 doubleclick.net
    '';
  };

  nix = {
    package = pkgs.nixUnstable;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      show-trace = true;

      trusted-users = [
        "@wheel"
        "root"
      ];

      trusted-substituters = [
        "https://cache.nixos.org"
        "https://devenv.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };

  environment = {
    defaultPackages = lib.mkForce [];
    systemPackages = with pkgs; [
      smartmontools
      gparted
      pciutils
      usbutils
      bat
      unar
    ];
    shellAliases = {
      offline-rebuild = "sudo nixos-rebuild switch --option substitute false";
      gen = "sudo nixos-rebuild switch";
      update = "sudo nix flake update --flake /etc/nixos";
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.haruka = {
      isNormalUser = true;
      initialPassword = "test";
      extraGroups = [
        "networkmanager"
        "wheel"
        "adbusers"
        "wireshark"
      ];
    };
  };

  security.sudo.execWheelOnly = true;

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  system = {
    stateVersion = "unstable";
    # includeBuildDependencies = true;
    # See https://linus.schreibt.jetzt/posts/include-build-dependencies.html#fn1
  };
}
