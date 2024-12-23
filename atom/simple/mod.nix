let
  pkgs = use.nixpkgs {
    inherit system;
  };

  pkgsFromFlake = use.nixpkgs.legacyPackages.${system};

  mkStringPackage =
    string:
    pkgs.runCommand string { } ''
      mkdir $out
      echo ${string} > $out/string.txt
    '';

in
{
  Packages.default = pkgs.hello;

  Packages.stringPackage = mkStringPackage use.local-lib.simpleString;
  Packages.hashString = mkStringPackage use.local-lib.stringHash;

  Packages.flakeHello = pkgsFromFlake.hello;
}
