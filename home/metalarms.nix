{ config, pkgs, ... }:

let
  myPkgs = import pkgs.path {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };

  devTools = with myPkgs; [
    git gcc cmake gnumake gdb valgrind neovim ripgrep fd curl unzip zip jq
  ];

  desktopApps = with myPkgs; [
    google-chrome
    masterpdfeditor
    vscodium
    htop
    tailscale
  ];
in
{
  home.stateVersion = "23.11";

  home.packages = devTools ++ desktopApps ++ [ myPkgs.home-manager ];

  programs.git = {
    enable = true;
    userName = "Douglas McKinley";
    userEmail = "your@email.com"; # replace this
  };

  programs.vscode = {
    enable = true;
    package = myPkgs.vscodium;

    profiles.default = {
      extensions = with myPkgs.vscode-extensions; [
        ms-python.python
        # vscodevim.vim  # ⛔️ Removed to disable Vim mode
      ];

      userSettings = {
        "editor.fontSize" = 14;
        "editor.tabSize" = 2;
        "git.enabled" = true;
        "git.path" = "git";
      };
    };
  };

  programs.bash.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
