{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  {
    darwinConfigurations."haruka-mac" = nix-darwin.lib.darwinSystem {
      modules = [
        {nixpkgs.hostPlatform = "aarch64-darwin";
         networking.hostName = "haruka-mac";
        }
        home-manager.darwinModules.home-manager
        {
          home-manager.users.haruka = import ./home.nix/haruka.nix;
        }
        ./configuration.nix/darwin.nix
      ];
    };
    darwinPackages = self.darwinConfigurations."haruka-mac".pkgs;
  };
}
