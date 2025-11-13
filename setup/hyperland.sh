#!/usr/bin/env bash

packages=(
  hyprland
  hyprshot
  hyprpicker
  hyprlock
  hypridle
  hyprpolkitagent
  hyprland-qtutils
  wofi
  waybar
  mako
  swaybg
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
)

install_packages "${packages[@]}"

log "Configuring auto-start for Hyprland on TTY1..."

BASH_PROFILE="$HOME/.bash_profile"

cat >"$BASH_PROFILE" <<'EOF'
# Start Hyprland automatically on TTY1
if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
    # Set Wayland environment
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=Hyprland
    export GDK_BACKEND=wayland
    export QT_QPA_PLATFORM=wayland

    # Start polkit agent for authentication dialogs
    if command -v hyprpolkitagent >/dev/null 2>&1; then
        hyprpolkitagent &
    fi

    # Start the compositor
    exec Hyprland
fi
EOF