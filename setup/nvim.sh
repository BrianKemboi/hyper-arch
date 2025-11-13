#!/usr/bin/env bash

packages=(
    nvim
    luarocks
    tree-sitter-cli
)

if ! command -v nvim &>/dev/null; then
  install_packages "${packages[@]}"
fi

# Backup existing config if it exists
if [[ -d ~/.config/nvim ]]; then
  log "Backing up existing Neovim config..."
  mv ~/.config/nvim ~/.config/nvim.bak.$(date +%s)
fi

# Install LazyVim starter config
git clone https://github.com/LazyVim/starter ~/.config/nvim

# Copy custom config
if [[ -d ~/.local/share/omarchy/config/nvim ]]; then
  cp -R ~/.local/share/omarchy/config/nvim/* ~/.config/nvim/
fi

# Remove git folder from starter
rm -rf ~/.config/nvim/.git

# Set relative number option if not already set
options_file=~/.config/nvim/lua/config/options.lua
grep -qxF 'vim.opt.relativenumber = false' "$options_file" || echo 'vim.opt.relativenumber = false' >>"$options_file"

# Optional: pre-install plugins
nvim --headless +'Lazy sync' +qall

log "Neovim setup complete!"
