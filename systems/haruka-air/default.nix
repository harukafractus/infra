{ pkgs, ... }: {
  networking.hostName = "haruka-air";
  nixpkgs.hostPlatform = "aarch64-darwin";
  services.nix-daemon.enable = true;

  system.defaults = {
    trackpad.Clicking = true;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    trackpad.Dragging = true;
  };
}