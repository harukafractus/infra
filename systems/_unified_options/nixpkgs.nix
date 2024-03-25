{ config, pkgs, ... }: {
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      show-trace = true;

      trusted-users = if pkgs.stdenv.isLinux then [
        "@wheel"
        "root"
      ] else if pkgs.stdenv.isDarwin then [
        "*"
      ] else throw "no system";
    };
  };
}
