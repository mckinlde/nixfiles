{ config, pkgs, ... }:

let
  # Allow unfree packages in user environment
  myPkgs = import pkgs.path {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };

  devTools = with myPkgs; [
    git gcc cmake gnumake gdb valgrind neovim ripgrep fd curl unzip zip jq
  ];

  desktopApps = with myPkgs; [
    masterpdfeditor
    vscodium
    htop
    tailscale
  ];
in
{
  home.stateVersion = "23.11";

  home.packages = devTools ++ desktopApps;

  programs.git = {
    enable = true;
    userName = "Douglas McKinley";
    userEmail = "your@email.com"; # replace
  };

  programs.vscode = {
    enable = true;
    package = myPkgs.vscodium;

    profiles.default = {
      extensions = with myPkgs.vscode-extensions; [
        ms-python.python
        vscodevim.vim
      ];

      userSettings = {
        "editor.fontSize" = 14;
        "editor.tabSize" = 2;
      };
    };
  };

  programs.bash.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
