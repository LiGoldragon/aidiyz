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

in
{
  SimpleString = "A simple string";
  StringHash = std.hashString "sha256" mod.simpleString;

  StringUsingLib = lib.concatMapStrings (x: "a" + x) [
    "foo"
    "bar"
  ];
}
