{ rev ? null, nixpkgsSrc ? null }:
assert rev -> nixpkgsSrc != null;
assert nixpkgsSrc -> rev != null;
let
  fetchNixpkgs = { rev, sha256 }:
    builtins.fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${rev}.tar.gz";
      inherit sha256;
    };

  nixpkgsFromRev = rev: builtins.fetchTree;

  pkgsFromRev = mkPkgs {
    inherit system;
    nixpkgs = nixpkgsFromRev rev;
  };

  result =
    if (rev != null)
    then pkgsFromRev
    else if (nixpkgsSrc != null)
    then pkgsFromNixpkgs
    else
      throw "MkSpecificPkgs: either `rev` or `nixpkgsSrc` must be defined";
in
result
