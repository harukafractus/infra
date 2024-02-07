{ config, pkgs, ... }:

{
  imports = [ ./gnome.nix ];

  # Enable audio: PipeWire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable iBus
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        rime
        mozc
      ];
    };
  };

  # Add font support: Noto Sans CJK
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      nur.repos.harukafractus.gothic-nguyen  # Sans for Han Nom
      source-han-sans
      source-han-mono
      source-han-serif
      source-han-code-jp
      nerdfonts
    ];
  };

  # Fix Flatpak and Qt system fonts
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    # Create an FHS mount to support flatpak host icons/fonts
    "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
    "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
  };
}
