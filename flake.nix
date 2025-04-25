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
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit system;

        pkgs = import nixpkgs { inherit system; };

        home.username = username;
        home.homeDirectory = "/home/${username}";

        programs.home-manager.enable = true;

        # Includes your actual user config
        imports = [ ./home/${username}.nix ];
      };

      apps.${system}.update = {
        type = "app";
        program = "${./update.sh}";
      };
    };
}
