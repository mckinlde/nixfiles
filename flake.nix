{
  description = "Metalarms's NixOS + Home Manager Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.metalarms = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/metalarms.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.metalarms = import ./home/metalarms.nix;
          }
        ];
      };

      homeConfigurations.metalarms = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./home/metalarms.nix
          {
            home.username = "metalarms";
            home.homeDirectory = "/home/metalarms";
            home.stateVersion = "23.11";
          }
        ];
        pkgs = nixpkgs.legacyPackages.${system};
      };

      apps.${system}.update = {
        type = "app";
        program = "${./update.sh}";
      };
    };
}
