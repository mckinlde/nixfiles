{ config, pkgs, ... }:

let
  devTools = with pkgs; [
    git
    gcc
    cmake
    gnumake
    gdb
    valgrind
    neovim
    ripgrep
    fd
    curl
    unzip
    zip
    jq
  ];

  desktopApps = with pkgs; [
    kdePackages.okular
    vscodium
    htop
  ];
in
{
  home.stateVersion = "23.11";

  home.packages = devTools ++ desktopApps;

  programs.git = {
    enable = true;
    userName = "Douglas McKinley";
    userEmail = "your@email.com"; # update this
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
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
