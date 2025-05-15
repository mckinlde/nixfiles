#!/usr/bin/env bash
set -euo pipefail

# Your desktop apps as in your nix config
desktop_apps=(
  google-chrome
  masterpdfeditor
  pgadmin4
  vscodium
  htop
  tailscale
  vlc
)

# Destination dir for user desktop entries
dest_dir="$HOME/.local/share/applications"
mkdir -p "$dest_dir"

echo "Updating GNOME desktop icons for your desktopApps..."

for app in "${desktop_apps[@]}"; do
  # Try to find nix store path for the app
  store_path=$(nix eval --raw "with import <nixpkgs> {}; ${app}.outPath" 2>/dev/null || true)
  
  if [[ -z "$store_path" ]]; then
    echo "⚠️ Could not find nix store path for '$app'. Skipping."
    continue
  fi

  # Look for .desktop files inside share/applications in that store path
  desktop_files=("$store_path/share/applications/"*.desktop)
  
  if [[ ${#desktop_files[@]} -eq 0 ]]; then
    echo "⚠️ No .desktop files found for '$app' in $store_path/share/applications/"
    continue
  fi

  for desktop_file in "${desktop_files[@]}"; do
    # Copy or symlink the desktop file to dest_dir
    filename=$(basename "$desktop_file")
    dest_file="$dest_dir/$filename"

    # Copy to local applications dir
    cp -f "$desktop_file" "$dest_file"
    echo "✔️ Installed $filename for $app"
  done
done

echo "Done updating desktop icons."
