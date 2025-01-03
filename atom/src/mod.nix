let
  pkgs-atom = use.nixpkgs-atom.pkgs;

  pkgs = use.nixpkgs {
    inherit system;
  };

  pkgsFromFlake = use.nixpkgs-flake.legacyPackages.${system};

  mkStringPackage =
    string:
    pkgs.runCommand string { } ''
      mkdir $out
      echo ${string} > $out/string.txt
    '';

  schemaCheckingPkg = pkgs.runCommand "simple-schema-check" { } ''
    # TODO
    touch $out
    echo -n "false" > $out
  '';

  failingPackage = pkgs.runCommand "simple-schema-check" { } ''
    exit 1
  '';

  failingPackageCheck = (std.tryEval (std.readFile failingPackage)).success || throw "package failed";

  packageCheck =
    (std.tryEval (std.readFile schemaCheckingPkg)).value == "false" || throw "package failed";

in
{
  Packages = {
    default = pkgs.hello;

    stringPackage = mkStringPackage use.local-lib.simpleString;
    hashString = mkStringPackage use.local-lib.stringHash;

    flakeHello = pkgsFromFlake.hello;

    assertedSchema = std.seq schemaCheckingPkg pkgs.hello;

    failingPackageSeq = std.seq failingPackageCheck pkgs.hello;
    packageCheck = std.seq packageCheck pkgs.hello;

    atomPkgsHello = pkgs-atom.hello;
  };
}
