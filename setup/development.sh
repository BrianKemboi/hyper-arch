#!/usr/bin/env bash

packages=(
  mariadb-libs
  postgresql-libs
  github-cli
  lazygit
  lazydocker-bin
)

install_packages "${packages[@]}"