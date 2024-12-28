{
  description = "Aidiyz (Ideas)";

  inputs.atom.url = "github:LiGoldragon/atom";

  outputs =
    { atom, ... }:
    atom.mkAtomicFlake {
      manifest = ./. + "/atom/simple@.toml";
      noSystemManifest = ./. + "/atom/local-lib@.toml";
    };
}
