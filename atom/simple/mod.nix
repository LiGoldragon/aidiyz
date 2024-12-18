let
  # TODO
  nixosHelloVMConfig = { };

  pkgs = use.nixpkgs {
    inherit system;
  };

in
{
  Packages.default = pkgs.hello;
  NixosHelloVM = use.nixos-lib.eval-config-minimal nixosHelloVMConfig;
}
