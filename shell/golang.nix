let
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8.tar.gz";
  }) {};
  GOPATH = toString ./go;

in pkgs.mkShell {
  packages = with pkgs; [
    go
    gotools
    golangci-lint
    gopls
    go-outline
    gopkgs
  ];
  inherit GOPATH;
  shellHook = ''export PATH="${GOPATH}/bin:$PATH"'';
}