{
  description = "Aidiyz (Ideas)";

  inputs = {
    atom.url = "github:LiGoldragon/atom";
    lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-atom = {
      url = "./flake-atom";
      inputs.atom.follows = "atom";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-atom.follows = "nixpkgs-atom";
    };

    nixpkgs-atom = {
      url = "github:criome/nixpkgs-atom";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs =
    {
      self,
      lib,
      atom,
      ...
    }@inputs:
    let
      inherit (inputs.lib) lib;

      introspection = {
        self = lib.traceSeqN 2 (builtins.removeAttrs self [ "introspection" ]) true;
        outputs = lib.traceSeqN 3 (builtins.removeAttrs self.outputs [ "introspection" ]) true;
        inputs = lib.traceSeqN 2 self.inputs true;
        description = (import (self.outPath + "/flake.nix")).description;
      };

      atomOutputs = atom.mkCustomAtomicFlake {
        inherit inputs;
        manifest = ./. + "/atom/simple@.toml";
        noSystemManifest = ./. + "/atom/local-lib@.toml";
        features = [ "flake" ];
      };

    in
    atomOutputs // { inherit introspection; };
}
