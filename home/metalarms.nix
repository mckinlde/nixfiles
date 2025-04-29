{ config, pkgs, ... }:

{
  home.stateVersion = "23.11"; # adjust to your current NixOS version

  # CLI tools for Electric Era challenge
  home.packages = with pkgs; [
    git
    gcc
    cmake
    make
    gdb
    valgrind
    neovim
    htop
    ripgrep
    fd
    curl
    unzip
    zip
    jq
    okular # PDF annotation
    vscodium # vsCode without telemetry; open with >> codium .
  ];

  programs.git = {
    enable = true;
    userName = "Douglas McKinley";
    userEmail = "your@email.com"; # update this
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      ms-python.python
      # Add other desired extensions here
    ];
    userSettings = {
      "editor.fontSize" = 14;
      "editor.tabSize" = 2;
      # Add other settings as needed
    };
  };


  # Optional shell setup
  programs.bash.enable = true;
  # programs.zsh.enable = true;

  # Enable basic direnv support (optional, useful for dev)
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
