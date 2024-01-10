{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ./desktop
    ./hyprland.nix
    ../hardware-configuration.nix
  ];

  virtualisation.waydroid.enable = true;

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

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh.enable = true;
      ohMyZsh.theme = "agnoster";
    };
    
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

  documentation = {
    dev.enable = false;
    doc.enable = false;
    enable = false;
    info.enable = false;
    man.enable = false;
    nixos.enable = false;
  };

  nix = {
    package = pkgs.nixUnstable;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      http-connections = 128;
      max-substitution-jobs = 128;
      cores = 0;
      show-trace = true;
    };
  };

  environment = {
    defaultPackages = lib.mkForce [];
    systemPackages = with pkgs; [
      python311Packages.python
      smartmontools
      gparted
      jwhois
      pciutils
      usbutils
      wget
      fcp
      dogdns
      bat
      unar
      tealdeer
    ];
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
      packages = with pkgs; [
        fastfetch
        fortune
      ];
    };
  };

  environment = {
    shellAliases = {
      ls = "ls -1lh --color=tty";
      cp = "fcp";
      dig = "dog";
      less = "bat";
      gc = "sudo nix-collect-garbage -d; offline-rebuild";
      gen = "sudo nix flake update --flake /etc/nixos; sudo nixos-rebuild switch";
      hmgen = "nix run home-manager/master -- init; home-manager switch --flake /etc/nixos";
      hmgc = "home-manager expire-generations -0days";
      offline-rebuild = "sudo nixos-rebuild switch --option substitute false";
    };
    shellInit = "
      ZSH_COMPDUMP=\"\$HOME/.cache/zsh/zcompcache\";
      
      function server() {
        local port=\"\${1:-5000}\"
        local is_sudo=\"\"
        if [[ \"\$2\" == \"--sudo\" ]]; then
          is_sudo=\"sudo\"
        fi
        echo \"Usage: server [port] [--sudo]\"
        \$is_sudo nix-shell -p python311Packages.python --command \"python -m http.server \$port\"
      };

      function python3-shell() {
        echo \"Usage: python3-shell [module1] [module2] ...\"
        nix-shell --pure -p \"pkgs.python311Packages.python.withPackages (pkgs: with pkgs; [ \$@ ])\" 
      };

      function codium() {
        (flatpak run com.vscodium.codium $*)
      };
    ";
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
