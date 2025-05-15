{ config, pkgs, ... }:

let
  devTools = with pkgs; [
    git gcc cmake gnumake gdb valgrind neovim ripgrep fd curl unzip zip jq
  ];

  desktopApps = with pkgs; [
    google-chrome
    masterpdfeditor
    pgadmin4
    vscodium
    htop
    tailscale
    vlc
  ];
in
{
  home.packages = devTools ++ desktopApps ++ [ pkgs.home-manager ];

  programs.git = {
    enable = true;
    userName = "Douglas McKinley";
    userEmail = "douglas.e.mckinley@gmail.com"; # 🔁 Replace this
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        # vscodevim.vim  # Uncomment if you want Vim keybindings
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
