{ pkgs, config, lib, ... }:
let
  inherit (pkgs) stdenv;
  inherit (lib) mkIf;
  mac-specific-pkgs = with pkgs; [
    utm
    qbittorrent
    vscodium
    telegram-desktop
  ];
in {
  imports = [
    #./linux/flatpak.nix
    ./linux/gnome.nix
  ];
  
  home = {
    username = "haruka";
    homeDirectory = if stdenv.isLinux then "/home/haruka" else "/Users/haruka";
    stateVersion = "23.11";
    shellAliases = {
      ls = "ls -1lh --color=tty";
      less = "bat";
      gc = "sudo nix-collect-garbage -d";
      hmgen = "nix run home-manager/master -- init; home-manager switch --flake /etc/nixos";
      hmgc = "home-manager expire-generations -0days";
    };
  };

  home.packages = with pkgs; [
    noto-fonts
    source-han-sans
    source-han-mono
    source-han-serif
    source-han-code-jp 
    nerdfonts
    sqlitebrowser # The only GUI app
  ] ++ (if stdenv.isDarwin then mac-specific-pkgs else []);

  fonts.fontconfig.enable = true;
  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh.enable = true;
      oh-my-zsh.theme = "agnoster";
    };
    hyfetch = {
      enable = true;
      settings = {
        mode = "rgb";
        preset = "rainbow";
        lightness = 0.6;
        color_align.mode = "horizontal";
        backend = "fastfetch";
      };
    };
    git = {
      enable = true;
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        user = {
          email = "106440141+harukafractus@users.noreply.github.com";
          name = "harukafractus";
          signingkey = "~/.ssh/id_rsa.pub";
        };
        gpg = {
          format = "ssh";
        };
      };
    };
  };
}