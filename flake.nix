{
  description = "Metalarms's Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      homeConfigurations.metalarms = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home/metalarms.nix
          {
            home.username = "metalarms";
            home.homeDirectory = "/home/metalarms";
            home.stateVersion = "23.11";
          }
        ];
      };
    };
}
