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
      inherit (Atom) importAtom;

      exportJSON = name: data: std.toFile (name + ".json") (std.toJSON data);

    in
    {
      atom = {
        introspection.simple = exportJSON "atom-module" (std.attrNames Atom);
        introspection.trace = exportJSON "atom-module" (std.trace (Atom) null);

        simple = importAtom { } (./. + "atom/simple/simple@.toml");

      };

    };
}
