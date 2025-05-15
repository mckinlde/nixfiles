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

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # Define your desktop apps here (same list as in metalarms.nix)
      desktopApps = [
        pkgs.google-chrome
        pkgs.masterpdfeditor
        pkgs.pgadmin4
        pkgs.vscodium
        pkgs.htop
        pkgs.tailscale
        pkgs.vlc
      ];

      desktopAppPaths = builtins.map (app: app.outPath) desktopApps;
      
    in {
      homeConfigurations.metalarms = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/metalarms.nix
          {
            home.username = "metalarms";
            home.homeDirectory = "/home/metalarms";
            home.stateVersion = "23.11";
          }
        ];
      };

      # Expose desktop app paths for shell scripts
      desktopApps = {
        inherit desktopApps;
        inherit desktopAppPaths;
      };
    };
}
