{ config, pkgs, ... }:

{
  # Allow unfree software (needed for tailscale)
  nixpkgs.config.allowUnfree = true;

  # Enable tailscale system service
  services.tailscale.enable = true;

  # Install tailscale CLI globally
  environment.systemPackages = with pkgs; [
    tailscale
  ];

  # Match your current system version
  system.stateVersion = "23.11";
}
