#!/usr/bin/env bash
set -e

cd ~/nixfiles

echo "🔄 Updating flake inputs..."
nix flake update

echo "✅ Lock updated. Committing changes..."
git add flake.lock
git commit -m "Automated flake.lock update: $(date +'%Y-%m-%d')"
git push

echo "🚀 Update complete!"
