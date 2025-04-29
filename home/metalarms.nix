{ config, pkgs, ... }:

{
  home.stateVersion = "23.11"; # adjust to your current NixOS version

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
  in {
    home.packages = devTools ++ desktopApps;
  }



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
        # add more extensions as needed
      ];

      userSettings = {
        "editor.fontSize" = 14;
        "editor.tabSize" = 2;
      };
    };
  };



  # Optional shell setup
  programs.bash.enable = true;
  # programs.zsh.enable = true;

  # Enable basic direnv support (optional, useful for dev)
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
