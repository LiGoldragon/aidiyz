let
  inherit (std) lib;

  # A concept that wasn't needed
  packageNames =
    let
      removeNixExt =
        str:
        let
          len = builtins.stringLength str;
        in
        builtins.substring 0 (len - 4) str;
    in
    std.filter (n: n != "mod.nix") (
      map (x: removeNixExt (std.baseNameOf x)) (std.attrNames (std.readDir ./.))
    );
  mkNamedPkgs = atom.mkPkgsWithNamedSrc (lib.getAttrs packageNames mod);

  matchManifestFile = string: std.match "(^.*@\.toml)" string;

  fileNames = [
    "whatever@.toml"
    "somethingElse.nix"
  ];

  # Doesnt work - atom changes the directory structure
  files = std.readDir ./.;

  mkStructuredMatch =
    name: value:
    let
      isFile = value == "file";
      matchResult = matchManifestFile name;
      isMatch = isFile && (matchResult != null);
      result = {
        inherit name;
        value = std.head matchResult;
      };
    in
    if isFile then result else { };

  mkFileMatch =
    name:
    let
      match = matchManifestFile name;
    in
    if (match != null) then match else [ ];

  matchTests = {
    tomlString = matchManifestFile "whatever@.toml";
    nonTomlString = matchManifestFile "somethingElse.nix";

    matchedList = std.concatMap mkFileMatch fileNames;

    structuredResult = std.mapAttrs mkStructuredMatch files;
  };

in
{
  SimpleString = "A simple string";
  StringHash = std.hashString "sha256" mod.simpleString;

  StringUsingLib = lib.concatMapStrings (x: "a" + x) [
    "foo"
    "bar"
  ];

  Tests = matchTests;
}
