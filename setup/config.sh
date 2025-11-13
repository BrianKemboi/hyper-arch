#!/usr/bin/env bash
cp -R ~/.local/share/${NAME}/config/* ~/.config/
mkdir -p ~/.local/share/applications
echo "source ~/.local/share/${NAME}/default/bash/rc" >~/.bashrc

# Set common git aliases
git config --global pull.rebase true
git config --global init.defaultBranch main

username="$(echo -n "$USER_NAME" | xargs)"
email="$(echo -n "$USER_EMAIL" | xargs)"

# Set Git user.name if non-empty
if [[ -n "$username" ]]; then
  git config --global user.name "$username"
fi

# Set Git user.email if non-empty
if [[ -n "$email" ]]; then
  git config --global user.email "$email"
fi