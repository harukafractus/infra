# Infra
Just another collection of NixOS / Home Manager configurations and Ansible Playbooks. These files are used to configure my laptops to work out-of-the-box.

### NixOS

The deployment process is pretty straightforward. For NixOS on a Surface Pro device, run:
```
sudo nixos-rebuild switch --flake .#haruka-surface
```
For Home Manager only, use:
```
nix run home-manager/master -- init; home-manager switch --flake [your.path]
```

### Playbook
- `arch-playbook` to install GNOME on Arch Linux Machine
- `docker-mastodon.yml` to deploy Mastodon via Docker on any distro