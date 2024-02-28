{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSUserEnv {
  name = "devbox";
  targetPkgs = pkgs: (with pkgs; [
    curl
    fish
    glibc
   ]);
  multiPkgs = pkgs: [ pkgs.dpkg ];
  runScript = "fish";
}).env
