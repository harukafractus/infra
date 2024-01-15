{ lib, pkgs, config, ... }:
with lib;                      
let
  cfg = config.workstation.wifi;
in {
  options.workstation.wifi = {
    provider = mkOption {
      type = types.str;
      default = "iwd";
    };
  };

  config = {
    networking = {
      dhcpcd.enable = cfg.provider == "wpa_supplicant";
      wireless.enable = cfg.provider == "wpa_supplicant";

      # Enable iwd ...for iwctl and its straightforward config
      wireless.iwd = {
        enable = cfg.provider == "iwd";
        settings = {
          General = {
            EnableNetworkConfiguration = true;
          };
          Settings = {
            AlwaysRandomizeAddress = true; 
          };
          Network = {
            EnableIPv6 = false;
          };
        };
      };

      # Use NetworkManager as the frontend
      networkmanager = {
        enable = cfg.provider != "none";
        wifi.backend = cfg.provider;
      };
    };
  };
}