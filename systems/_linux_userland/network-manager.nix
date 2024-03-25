{ config, pkgs, ... }: {
  networking = {
    dhcpcd.enable = false;
    wireless.enable = false;  # Disables wpa_supplicant
    wireless.iwd = {
      enable = true;          # Enables iwd, iwctl
      settings = {
        Settings = {
          Hidden = true;      # Enable connection to hidden networks
          AlwaysRandomizeAddress = true; 
          AutoConnect = true;
        };
      };
    };

    networkmanager = {
      enable = true;          # Enables NetworkManager, nmtui
      wifi.backend = "iwd";
    };
  };
}