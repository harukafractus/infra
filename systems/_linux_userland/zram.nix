{ config, pkgs, ... }: {
  zramSwap = {
    enable = true;
    memoryPercent = 100;
    algorithm = "zstd";
  };
}