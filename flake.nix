# /mnt/etc/nixos/flake.nix
{
  inputs = {
    # NOTE: Replace "nixos-24.11" with that which is in system.stateVersion of
    # configuration.nix. You can also use latter versions if you wish to
    # upgrade.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{ self, nixpkgs, ... }:
    {
      # NOTE: 'nixos' is the default hostname set by the installer
      nixosConfigurations.utm = nixpkgs.lib.nixosSystem {
        # NOTE: Change this to aarch64-linux if you are on ARM
        system = "aarch64-linux";
        modules = [
          ./configuration.nix
          inputs.disko.nixosModules.disko
        ];
      };
    };
}
