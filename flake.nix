{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable/";
    nur.url = github:nix-community/NUR;
    hm-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    asahi.url = "github:tpwrules/nixos-apple-silicon";
    asahi.inputs.nixpkgs.follows = "nixpkgs";

    # Nix darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }@attrs: 
  let 
    systemConf = (
      import ./systems {inherit attrs nixpkgs nix-darwin home-manager;}
    );
  in {
    # Declare NixOS and nix-darwin stuff
    nixosConfigurations = systemConf;
    darwinConfigurations = systemConf;
  };
}
