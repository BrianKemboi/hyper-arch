if ! command -v gum &>/dev/null; then
  log "Installing gum..."
  yay -S --noconfirm --needed gum
else
  log "gum already installed"
fi

log "Enter identification for git and autocomplete..."
export USER_NAME=$(gum input --placeholder "Enter full name" --prompt "Name: ")
export USER_EMAIL=$(gum input --placeholder "Enter email address" --prompt "Email: ")