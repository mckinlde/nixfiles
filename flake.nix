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

    desktopApps = {
      google-chrome = pkgs.google-chrome;
      masterpdfeditor = pkgs.masterpdfeditor;
      pgadmin4 = pkgs.pgadmin4;
      vscodium = pkgs.vscodium;
      htop = pkgs.htop;
      tailscale = pkgs.tailscale;
      vlc = pkgs.vlc;
    };

    desktopAppPaths = builtins.mapAttrs (_: app: app.outPath) desktopApps;

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

    # expose as attribute sets
    desktopApps = desktopApps;
    desktopAppPaths = desktopAppPaths;
  };
}
