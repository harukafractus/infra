arch-playbook
=========

The **arch-playbook** Ansible playbook sets up Arch Linux by installing a minimal GNOME Desktop Environment, useful Flatpak apps, and the Nix package manager.

Please ensure that this playbook is executed on localhost, using a non-root account with proper sudo access.

Deployment
------------
- Install Ansible and Git
  > sudo pacman -S ansible git

- Install dependencies 
  > ansible-galaxy install -r requirements.yml

- Deploy the playbook as a non-root user
  > ansible-playbook deploy.yml -K -vvvv

