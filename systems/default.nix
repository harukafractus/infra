# Configuration for each device using Nix

{ nixpkgs, nix-darwin, home-manager, attrs, ... }: {
  ### My Macbook that runs Asahi Linux / NixOS
  "haruka-asahi" = nixpkgs.lib.nixosSystem {
    specialArgs = attrs;
    modules = [
      home-manager.nixosModules.home-manager
      ./haruka-asahi
      ../users/haruka
    ];
  };
  "haruka-air" = nix-darwin.lib.darwinSystem {
      modules = [
        home-manager.darwinModules.home-manager
        ./haruka-air
        ../users/haruka
      ];
    };
}