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
      homeConfigurations.metalarms = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./home/metalarms.nix
          {
            home.username = "metalarms";
            home.homeDirectory = "/home/metalarms";
            home.stateVersion = "23.11"; # Match your current system or config
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
