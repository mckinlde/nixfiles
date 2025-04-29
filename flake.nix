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
      username = "metalarms";
    in {
      homeConfigurations.metalarms = home-manager.lib.homeManagerConfiguration {
        inherit system;
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home/metalarms.nix ];
        # optional, if you're not setting it in home.nix:
        # username = "metalarms";
        # homeDirectory = "/home/metalarms";
      };


      apps.${system}.update = {
        type = "app";
        program = "${./update.sh}";
      };
    };
}
