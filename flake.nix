{
  description = "Aidiyz (Ideas)";

  inputs = {
    atom.url = "github:LiGoldragon/atom";
    lib.url = "github:ekala-project/nix-lib";
  };

  outputs = inputs@{ self, ... }:
    let
      std = inputs.lib.lib // builtins;

      Atom = inputs.atom.mod;
      inherit (inputs.atom) importAtom;

      exportJSON = name: data: std.toFile (name + ".json") (std.toJSON data);

    in
    {
      atom = {
        introspection.simple = exportJSON "atom-module" (std.attrNames Atom);

        importSimpleAtom = importAtom { } (./. + "/atom/simple@.toml");

      };

    };
}
