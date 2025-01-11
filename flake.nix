{
  description = "Aidiyz (Ideas)";

  inputs = {
    atom.url = "github:LiGoldragon/atom";
    lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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

      atomOutputs = atom.mkAtomicFlake {
        manifest = ./. + "/atom/simple@.toml";
        noSystemManifest = ./. + "/atom/local-lib@.toml";
      };

    in
    atomOutputs
    // {
      introspection = {
        self = lib.traceSeqN 2 (builtins.removeAttrs self [ "introspection" ]) true;
        outputs = lib.traceSeqN 3 (builtins.removeAttrs self.outputs [ "introspection" ]) true;
        inputs = lib.traceSeqN 2 self.inputs true;
      };
    };
}
