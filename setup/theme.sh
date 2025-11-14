#!/usr/bin/env bash
set -e

sudo pacman -S --noconfirm kvantum-qt5 gnome-themes-extra

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

THEMES_SRC="$HOME/.local/share/hyper-arch/themes"
BG_SRC="$HOME/.local/share/hyper-arch/backgrounds"

THEMES_DEST="$HOME/.config/hyper-arch/themes"
BG_DEST="$HOME/.config/hyper-arch/backgrounds"
CURRENT="$HOME/.config/hyper-arch/current"

mkdir -p "$THEMES_DEST" "$BG_DEST" "$CURRENT"

for dir in "$THEMES_SRC"/*; do
    ln -snf "$dir" "$THEMES_DEST/"
done

for img in "$BG_SRC"/*; do
    ln -snf "$img" "$BG_DEST/"
done

### --- Set Initial Theme --- ###
ln -snf "$THEMES_DEST/tokyo-night" "$CURRENT/theme"
ln -snf "$BG_DEST/tokyo-night" "$CURRENT/backgrounds"

# Default background
ln -snf "$CURRENT/backgrounds/1-tokyo-night.jpg" "$CURRENT/background"

### --- App Config Symlinks --- ###
mkdir -p ~/.config/{hypr,wofi,nvim/lua/plugins,btop/themes,mako}

ln -snf "$CURRENT/theme/hyprlock.conf" ~/.config/hypr/hyprlock.conf
ln -snf "$CURRENT/theme/wofi.css" ~/.config/wofi/style.css
ln -snf "$CURRENT/theme/neovim.lua" ~/.config/nvim/lua/plugins/theme.lua
ln -snf "$CURRENT/theme/btop.theme" ~/.config/btop/themes/current.theme
ln -snf "$CURRENT/theme/mako.ini" ~/.config/mako/config
