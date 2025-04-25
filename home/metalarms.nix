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
  ];

  programs.git = {
    enable = true;
    userName = "Douglas McKinley";
    userEmail = "your@email.com"; # update this
  };

  # Optional shell setup
  programs.bash.enable = true;
  # programs.zsh.enable = true;

  # Enable basic direnv support (optional, useful for dev)
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
