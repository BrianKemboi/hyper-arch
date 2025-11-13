sudo pacman -S --needed --noconfirm base-devel || error_exit "Failed to install base-devel."

if ! command -v yay &>/dev/null; then
  log "Installing yay (AUR helper)..."

  tmpdir=$(mktemp -d)
  trap 'rm -rf "$tmpdir"' EXIT

  if ! git clone --depth 1 https://aur.archlinux.org/yay-bin.git "$tmpdir/yay-bin" >/dev/null 2>&1; then
    error_exit "Failed to clone yay-bin repository from AUR."
  fi

  cd "$tmpdir/yay-bin"

  if ! makepkg -si --noconfirm --needed; then
    error_exit "Failed to build or install yay from source."
  fi

  cd - >/dev/null
  log "yay has been installed successfully."
else
  log "yay is already installed."
fi
