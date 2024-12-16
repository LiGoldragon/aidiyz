let
  # TODO
  nixosHelloVMConfig = { };

  pkgs = use.nixpkgs {
    inherit (use) lib;
    localSystem = "x86_64-linux";
  };

in
{
  Hello = pkgs.hello;
  NixosHelloVM = use.nixos-lib.eval-config-minimal nixosHelloVMConfig;
}
