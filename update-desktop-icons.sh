#!/usr/bin/env bash
# chmod +x update-desktop-icons.sh
set -euo pipefail

dest_dir="$HOME/.local/share/applications"
mkdir -p "$dest_dir"

echo "Updating GNOME desktop icons for your desktopApps..."

# Get JSON array of store paths from flake output
if ! command -v jq &>/dev/null; then
  echo "❌ 'jq' is required but not installed. Please install it."
  exit 1
fi

# Evaluate the flake output to get desktop app store paths
mapfile -t store_paths < <(
  nix eval --json ~/nixfiles#desktopApps.desktopAppPaths | jq -r '.[]'
)

if [[ ${#store_paths[@]} -eq 0 ]]; then
  echo "⚠️ No desktop app store paths found from flake output. Exiting."
  exit 1
fi

for store_path in "${store_paths[@]}"; do
  desktop_files=("$store_path/share/applications/"*.desktop)

  if [[ ! -e "${desktop_files[0]}" ]]; then
    echo "⚠️ No .desktop files found in $store_path/share/applications/"
    continue
  fi

  for desktop_file in "${desktop_files[@]}"; do
    filename=$(basename "$desktop_file")
    dest_file="$dest_dir/$filename"
    cp -f "$desktop_file" "$dest_file"
    echo "✔️ Installed $filename from $store_path"
  done
done

echo "✅ Done updating desktop icons."
