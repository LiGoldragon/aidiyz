let
  inherit (use.nixpkgs-atom) lib pkgs;

in
{
  Packages.hello = pkgs.hello;
}
