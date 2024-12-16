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

      atom = {
        introspection.attrNames = exportJSON "atom-module" (std.attrNames Atom);
        simple = importAtom { } (./. + "/atom/simple@.toml");
      };

    in
    {
      inherit atom;

      packages.x86_64-linux.default = atom.simple.hello;

    };
}
