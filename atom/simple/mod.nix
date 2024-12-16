let
  # TODO
  nixosHelloVMConfig = { };

  pkgs = atom.nixpkgs {
    inherit (atom) lib;
    localSystem = "x86_64-linux";
  };

in
{
  Hello = pkgs.hello;
  NixosHelloVM = atom.nixos-lib.eval-config-minimal nixosHelloVMConfig;
}
