let
  pkgs = use.nixpkgs {
    inherit system;
  };

  mkStringPackage =
    string:
    pkgs.runCommand string { } ''
      mkdir $out
      echo ${string} > $out/string.txt
    '';

in
{
  Packages.default = pkgs.hello;
  Packages.simpleString = mkStringPackage use.local-lib.simpleString;
  Packages.hashString = mkStringPackage use.local-lib.stringHash;

}
