#!/usr/bin/env bash
set -euo pipefail

# ===============================
# Package installer
# ===============================
install_packages() {
  local packages=("$@")
  yay -S --noconfirm --needed "${packages[@]}" || warn "Some packages failed to install."
}

web_app() {
  # -------------------------------
  # Check arguments
  # -------------------------------
  if [ "$#" -ne 3 ]; then
    echo "Usage: web_app <AppName> <AppURL> <IconURL>"
    echo "Example: web_app "YouTube" https://youtube.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/youtube.png"
    return 1
  fi

  local APP_NAME="$1"
  local APP_URL="$2"
  local ICON_URL="$3"
  local ICON_DIR="$HOME/.local/share/applications/icons"
  local DESKTOP_DIR="$HOME/.local/share/applications"
  local DESKTOP_FILE="${DESKTOP_DIR}/${APP_NAME}.desktop"
  local ICON_PATH="${ICON_DIR}/${APP_NAME}.png"

  mkdir -p "$ICON_DIR" "$DESKTOP_DIR"

  # -------------------------------
  # Download icon
  # -------------------------------
  if ! curl -fsSL -o "$ICON_PATH" "$ICON_URL"; then
    error_exit "Failed to download icon from $ICON_URL"
  fi

  # -------------------------------
  # Browser detection
  # -------------------------------
  local BROWSER="${WEB_APP_BROWSER:-}"
  if [ -z "$BROWSER" ]; then
    for b in chromium google-chrome brave microsoft-edge; do
      if command -v "$b" >/dev/null 2>&1; then
        BROWSER="$b"
        break
      fi
    done
  fi

  [ -z "$BROWSER" ] && error_exit "No supported browser found (chromium, google-chrome, brave, microsoft-edge). Set WEB_APP_BROWSER to override."

  # -------------------------------
  # Wayland flags (Hyprland optimized)
  # -------------------------------
  local WAYLAND_FLAGS="--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer \
--ozone-platform=wayland \
--gtk-version=4 \
--enable-wayland-ime \
--force-device-scale-factor=1"

  # -------------------------------
  # Create .desktop file
  # -------------------------------
  cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Name=$APP_NAME
Comment=$APP_NAME Web App
Exec=$BROWSER --new-window $WAYLAND_FLAGS --app="$APP_URL" --class="$APP_NAME"
Terminal=false
Type=Application
Icon=$ICON_PATH
StartupNotify=true
Categories=Network;WebBrowser;
EOF

  chmod +x "$DESKTOP_FILE"

  # -------------------------------
  # Optional desktop update
  # -------------------------------
  command -v update-desktop-database >/dev/null 2>&1 && update-desktop-database ~/.local/share/applications >/dev/null 2>&1
}
