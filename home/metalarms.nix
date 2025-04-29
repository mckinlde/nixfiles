{ config, pkgs, ... }:

{
  home.stateVersion = "23.11"; # adjust to your current NixOS version

  # CLI tools for Electric Era challenge
  home.packages = [
    pkgs.git
    pkgs.gcc
    pkgs.cmake
    pkgs.make
    pkgs.gdb
    pkgs.valgrind
    pkgs.neovim
    pkgs.htop
    pkgs.ripgrep
    pkgs.fd
    pkgs.curl
    pkgs.unzip
    pkgs.zip
    pkgs.jq
    pkgs.okular
    pkgs.vscodium
  ];


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
