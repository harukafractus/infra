{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.sessionPackages = [
      # Session Manager only; 
      # Not installing the metapackage
      pkgs.gnome.gnome-session.sessions
    ];
  };

  services.gnome = {
    core-shell.enable = true;         # Install package gnome-shell
    core-os-services.enable = true;   # Enables polkit, xdg, mime, dconf
    sushi.enable = true;              # File preview for nautilus
  };

  environment.systemPackages = with pkgs // pkgs.gnome ; [
    gparted
    gnome-disk-utility
    baobab
    nautilus
    gnome-characters
    gnome-console
    gnome-color-manager
  ];
}