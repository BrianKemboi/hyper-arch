#!/usr/bin/env bash

# Function to check if a desktop file exists
desktop_exists() {
    local desktop="$1"
    if [[ -f "$HOME/.local/share/applications/$desktop" ]] || [[ -f "/usr/share/applications/$desktop" ]]; then
        return 0
    else
        warn "$desktop not found. Skipping..."
        return 1
    fi
}

# Update desktop database
update-desktop-database ~/.local/share/applications

# ---------------------------
# Default Image Viewer: imv
# ---------------------------
image_types=(
    image/png
    image/jpeg
    image/gif
    image/webp
    image/bmp
    image/tiff
)
if desktop_exists "imv.desktop"; then
    for type in "${image_types[@]}"; do
        xdg-mime default imv.desktop "$type"
    done
fi

# ---------------------------
# Default PDF Viewer: Evince
# ---------------------------
if desktop_exists "org.gnome.Evince.desktop"; then
    xdg-mime default org.gnome.Evince.desktop application/pdf
fi

# ---------------------------
# Default Web Browser: Chromium
# ---------------------------
if desktop_exists "chromium.desktop"; then
    xdg-settings set default-web-browser chromium.desktop
    xdg-mime default chromium.desktop x-scheme-handler/http
    xdg-mime default chromium.desktop x-scheme-handler/https
fi

# ---------------------------
# Default Video Player: mpv
# ---------------------------
video_types=(
    video/mp4
    video/x-msvideo
    video/x-matroska
    video/x-flv
    video/x-ms-wmv
    video/mpeg
    video/ogg
    video/webm
    video/quicktime
    video/3gpp
    video/3gpp2
    video/x-ms-asf
    video/x-ogm+ogg
    video/x-theora+ogg
    application/ogg
)
if desktop_exists "mpv.desktop"; then
    for type in "${video_types[@]}"; do
        xdg-mime default mpv.desktop "$type"
    done
fi

log "Default applications updated successfully."
