#!/usr/bin/env bash
packages=(
  brightnessctl
  playerctl
  pamixer
  pavucontrol
  wireplumber  
  fcitx5 
  fcitx5-gtk
  fcitx5-qt
  fcitx5-configtool
  wl-clip-persist
  clipse-bin
  nautilus sushi
  ffmpegthumbnailer
  gnome-calculator
  chromium
  mpv 
  evince
  imv
)

install_packages "${packages[@]}"