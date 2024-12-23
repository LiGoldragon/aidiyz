let
  inherit (std) lib;
in
{
  SimpleString = "A simple string";
  StringHash = std.hashString "sha256" mod.simpleString;

  StringUsingLib = lib.concatMapStrings (x: "a" + x) [
    "foo"
    "bar"
  ];
}
