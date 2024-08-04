{
  description = "Nicolas's development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    {
      nixosConfigurations = {
        nixos-vmware = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./hosts/nixos-vmware/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nicolas = import ./hosts/nixos-vmware/home.nix;
            }
          ];
        };
      };
    };
}
