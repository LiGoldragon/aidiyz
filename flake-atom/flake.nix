{
  description = "Flake Atom";

  inputs = {
    atom.url = "github:LiGoldragon/atom";
    lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-atom.url = "github:criome/nixpkgs-atom";
    nixpkgs-atom.flake = false;
  };

  outputs =
    { atom, ... }@inputs:
    atom.mkCustomAtomicFlake {
      inherit inputs;
      manifest = ./. + "/flake-atom@.toml";
    };

}
