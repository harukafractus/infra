{ pkgs, ... }: {
  # Enable support for btrfs, apfs, ext4, ...
  boot.supportedFilesystems = [
    "btrfs"
    "ext4"
    "apfs"
  ];
}