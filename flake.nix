{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable/";
    hm-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    asahi.url = "github:tpwrules/nixos-apple-silicon/15dbcfd42d9f4924b2f9cca5942d3cb0048e147f";
    asahi.inputs.nixpkgs.follows = "nixpkgs";

    # Nix darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, asahi, ... }@attrs: {
    nixosConfigurations."nix-isnt-xnu" = nixpkgs.lib.nixosSystem {
      specialArgs = attrs;
      modules = [
        home-manager.nixosModules.home-manager
        asahi.nixosModules.apple-silicon-support
        ./devices/nix-isnt-xnu
        ./users/haruka
      ];
    };
  
    darwinConfigurations."walled-garden" = attrs.nix-darwin.lib.darwinSystem {
      modules = [
        home-manager.darwinModules.home-manager
        ./devices/walled-garden
        ./users/haruka
      ];
    };
  };
}
