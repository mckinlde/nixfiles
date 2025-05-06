{ config, pkgs, ... }:

{
  # Allow unfree packages (needed for tailscale, vscodium, etc.)
  nixpkgs.config.allowUnfree = true;

  # Bootloader configuration for UEFI system using systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define root filesystem (ext4 on /dev/sda2)
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6c6497fe-44de-4c73-8897-0478718273d9";
    fsType = "ext4";
  };

  # Define boot filesystem (vfat on /dev/sda1)
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D4C9-DA21";
    fsType = "vfat";
  };

  # Declare your user
  users.users.metalarms = {
    isNormalUser = true;
    group = "metalarms";
    extraGroups = [ "wheel" "networkmanager" ];  # sudo and network access
    shell = pkgs.bash;
  };

  # Declare the user's primary group
  users.groups.metalarms = {};


  # Enable the GNOME display manager and desktop
  # services.xserver.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.defaultSession = "gnome";

  # Needed for graphical sessions
  hardware.opengl.enable = true;

  # Enable the Tailscale service
  services.tailscale.enable = true;

  # Add Tailscale CLI to system packages
  environment.systemPackages = with pkgs; [
    tailscale
  ];

  # System version for compatibility (don’t change unless upgrading NixOS)
  system.stateVersion = "23.11";
}
