{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable/";
    flatpak.url = "github:gmodena/nix-flatpak";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Surface 6.6.13
    hardware.url = "github:nixos/nixos-hardware/abff72bb97ac85cdd192f32aecbed914ead928db";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    flatpak,
    hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      # Surface Pro
      "haruka-surface" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          {networking.hostName = "haruka-surface";}
          hardware.nixosModules.microsoft-surface-pro-intel
          ./nixos/laptop.nix
        ];
      };
      # Generic Laptop
      "haruka-laptop" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          {networking.hostName = "haruka-laptop";}
          ./nixos/laptop.nix
          ./nixos/hyprland.nix

        ];
      };
    };

    homeConfigurations = {
      "haruka" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          flatpak.homeManagerModules.nix-flatpak
          ./home-manager/haruka.nix
        ];
      };
    };
  };
}
