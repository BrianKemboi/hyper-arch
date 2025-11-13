#!/usr/bin/env bash
set -euo pipefail

NAME="hyper-arch"
REPO="${REPO:-BrianKemboi/hyper-arch}"
REPO_URL="https://github.com/${REPO}.git"
INSTALL_DIR="${HOME}/.local/share/${NAME}"
REPO_REF="${REPO_REF:-main}"

# ===============================
# Logging functions
# ===============================
log() { echo -e "\e[36m[INFO]\e[0m $*"; }
warn() { echo -e "\e[33m[WARN]\e[0m $*" >&2; }
error_exit() { echo -e "\e[31m[ERROR]\e[0m $*" >&2; exit 1; }


if ! command -v git &>/dev/null; then
  log "Git not found. Installing..."
  sudo pacman -Sy --noconfirm --needed git || error_exit "Failed to install git."
fi

log "Cloning ${NAME} from: ${REPO_URL}"

if [[ -d "${INSTALL_DIR}/.git" ]]; then
  log "Repository already exists. Updating..."
  git -C "${INSTALL_DIR}" fetch --all --quiet
  git -C "${INSTALL_DIR}" reset --hard "origin/${REPO_REF}" --quiet
else
  git clone --branch "${REPO_REF}" --depth 1 "${REPO_URL}" "${INSTALL_DIR}" || \
    error_exit "Failed to clone repository."
fi

if [[ "${REPO_REF}" != "main" ]]; then
  log "Switching to branch: ${REPO_REF}"
  git -C "${INSTALL_DIR}" checkout "${REPO_REF}" --quiet || \
    error_exit "Branch ${REPO_REF} not found."
fi

source $INSTALL_DIR/functions.sh
INSTALL_SCRIPT="${INSTALL_DIR}/setup/all.sh"

if [[ -x "${INSTALL_SCRIPT}" ]]; then
  log "Starting installation..."
  source "${INSTALL_SCRIPT}"
else
  error_exit "Installer script not found or not executable: ${INSTALL_SCRIPT}"
fi

log "Installation completed successfully!"
