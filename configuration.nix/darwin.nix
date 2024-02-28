{ pkgs, ... }: {

  # Not included in path if not enabled
  programs.zsh.enable = true;
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = "nix-command flakes";
    settings.auto-optimise-store = true;
  };

  environment.systemPackages = with pkgs; [
    unar
    bat
    android-tools
    util-linux
  ];

  users.users.haruka = {
    name = "haruka";
    home = "/Users/haruka";
  };

  system.defaults = {
    trackpad.Clicking = true;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    trackpad.Dragging = true;
  };
}