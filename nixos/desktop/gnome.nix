{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
    displayManager = {
      gdm.enable = true;
      sessionPackages = [ pkgs.gnome.gnome-session.sessions ];
    };
  };

  services.gnome = {
    core-shell.enable = true;
    core-os-services.enable = true;
    sushi.enable = true;
  };

  environment.systemPackages = with pkgs // pkgs.gnome ; [
    gnome-disk-utility
    baobab
    nautilus
    gnome-characters
    gnome-console
    gnome-color-manager
  ];

  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
}
