{
  description = "Aidiyz (Ideas)";

  inputs.atom.url = "github:LiGoldragon/atom";

  outputs =
    inputs@{ self, atom, ... }:
    atom.mkAtomicFlake {
      manifest = ./. + "/atom/simple@.toml";
      noSystemManifest = ./. + "/atom/local-lib@.toml";
    };
}
