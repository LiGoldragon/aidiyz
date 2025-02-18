{
  description = "Flake Atom";

  inputs = {
    atom.url = "github:LiGoldragon/atom";
    lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-atom = {
      url = "github:criome/nixpkgs-atom";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.atom.mkAtomicFlake inputs (./. + "/flake-atom@.toml");
}
