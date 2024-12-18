{
  description = "Aidiyz (Ideas)";

  inputs = {
    atom.url = "github:LiGoldragon/atom";
    lib.url = "github:ekala-project/nix-lib";
  };

  outputs =
    inputs@{ self, atom, ... }:
    let
      std = inputs.lib.lib // builtins;

      exportJSON = name: data: std.toFile (name + ".json") (std.toJSON data);

      simpleAtomManifestFile = ./. + "/atom/simple@.toml";

    in
    atom.mkAtomicFlake { manifest = simpleAtomManifestFile; };
}
