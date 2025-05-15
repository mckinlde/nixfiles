#!/usr/bin/env bash
set -euo pipefail

desktop_apps=(
  google-chrome
  masterpdfeditor
  pgadmin4
  vscodium
  htop
  tailscale
  vlc
)

dest_dir="$HOME/.local/share/applications"
mkdir -p "$dest_dir"

echo "Updating GNOME desktop icons for your desktopApps..."

# Define custom .desktop files for apps that lack them in nix store
declare -A custom_desktops

custom_desktops[pgadmin4]='
[Desktop Entry]
Version=1.0
Name=pgAdmin 4
Comment=PostgreSQL Management Tool
Exec=pgadmin4
Icon=pgadmin4
Terminal=false
Type=Application
Categories=Development;Database;
'

custom_desktops[vlc]='
[Desktop Entry]
Version=1.0
Name=VLC media player
Comment=Play your media files
Exec=vlc %U
Icon=vlc
Terminal=false
Type=Application
Categories=AudioVideo;Player;Recorder;
'

custom_desktops[tailscale]='
[Desktop Entry]
Version=1.0
Name=Tailscale
Comment=Secure VPN service
Exec=tailscale up
Icon=tailscale
Terminal=false
Type=Application
Categories=Network;
'

custom_desktops[masterpdfeditor]='
[Desktop Entry]
Version=1.0
Name=Master PDF Editor
Comment=Edit PDF documents
Exec=masterpdfeditor
Icon=masterpdfeditor
Terminal=false
Type=Application
Categories=Office;Graphics;
'

custom_desktops[vscodium]='
[Desktop Entry]
Version=1.0
Name=VSCodium
Comment=Open-source VS Code editor
Exec=vscodium %F
Icon=vscodium
Terminal=false
Type=Application
Categories=Development;IDE;
'

for app in "${desktop_apps[@]}"; do
  store_path=$(nix eval --raw "./#desktopAppPaths.${app}" 2>/dev/null || true)

  if [[ -z "$store_path" ]]; then
    echo "⚠️ Could not find nix store path for '$app'. Skipping."
    continue
  fi
  
  if [[ -z "$store_path" ]]; then
    echo "⚠️ Could not find nix store path for '$app'. Skipping."
    continue
  fi

  desktop_files=("$store_path/share/applications/"*.desktop)
  found_any=false
  
  if [[ ${#desktop_files[@]} -gt 0 && -e "${desktop_files[0]}" ]]; then
    for desktop_file in "${desktop_files[@]}"; do
      filename=$(basename "$desktop_file")
      cp -f "$desktop_file" "$dest_dir/$filename"
      echo "✔️ Installed $filename for $app"
      found_any=true
    done
  fi

  if ! $found_any; then
    # Check if we have a custom desktop entry for this app
    if [[ -n "${custom_desktops[$app]:-}" ]]; then
      desktop_file="$dest_dir/$app.desktop"
      echo "${custom_desktops[$app]}" > "$desktop_file"
      echo "✨ Created custom desktop entry for $app"
      found_any=true
    else
      echo "⚠️ No .desktop files found and no custom entry for '$app'. Skipping."
    fi
  fi
done

echo "✅ Done updating desktop icons."
