# Infra
Just another NixOS / Home Manager configuration. These files are used to configure my laptops to work out-of-the-box.

### Deployment

The deployment process is pretty straightforward. For NixOS on a Surface Pro device, run:
```
sudo nixos-rebuild switch --flake .#haruka-surface
```
For Home Manager only, use:
```
nix run home-manager/master -- init; home-manager switch --flake [your.path]
```