{
  description = "Flake Atom";

  inputs = {
    atom.url = "github:LiGoldragon/atom";
    lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { atom, ... }@inputs:
    atom.mkAtomicFlake {
      inherit inputs;
      manifest = ./. + "/flake-atom@.toml";
    };

}
