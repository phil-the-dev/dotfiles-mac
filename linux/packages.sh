#!/bin/bash

# Detect the Linux package manager
detectPackageManager() {
  if hash apt-get 2>/dev/null; then
    PKG_MANAGER="apt"
  elif hash dnf 2>/dev/null; then
    PKG_MANAGER="dnf"
  elif hash pacman 2>/dev/null; then
    PKG_MANAGER="pacman"
  else
    error "No supported package manager found (apt, dnf, pacman)"
    return 1
  fi
  info "Detected package manager: $PKG_MANAGER"
}

updatePackages() {
  info "Updating package lists..."
  case $PKG_MANAGER in
    apt)    sudo apt-get update ;;
    dnf)    sudo dnf check-update || true ;;
    pacman) sudo pacman -Sy ;;
  esac
}

installPackage() {
  info "Installing $@..."
  case $PKG_MANAGER in
    apt)    sudo apt-get install -y "$@" ;;
    dnf)    sudo dnf install -y "$@" ;;
    pacman) sudo pacman -S --noconfirm "$@" ;;
  esac
}

installMainPackages() {
  info "Installing main packages..."
  detectPackageManager
  updatePackages

  # Cross-platform CLI tools
  installPackage jq curl git wget

  # Desktop apps (apt/snap-based — adjust per distro)
  case $PKG_MANAGER in
    apt)
      # Apps available via apt or snap
      installPackage firefox
      if hash snap 2>/dev/null; then
        info "Installing snap packages..."
        sudo snap install discord 2>/dev/null || info "discord snap not available"
        sudo snap install slack 2>/dev/null || info "slack snap not available"
        sudo snap install spotify 2>/dev/null || info "spotify snap not available"
      else
        info "Snap not available. Install Discord, Slack, and Spotify manually."
      fi
      ;;
    dnf)
      installPackage firefox
      info "Install Discord, Slack, and Spotify via Flatpak or manually."
      ;;
    pacman)
      installPackage firefox
      info "Install Discord, Slack, and Spotify from the AUR or Flatpak."
      ;;
  esac
}

installDevPackages() {
  info "Installing dev packages..."
  detectPackageManager
  updatePackages

  # Core dev tools
  installPackage zsh git curl

  # Docker
  case $PKG_MANAGER in
    apt)
      installPackage docker.io docker-compose
      sudo usermod -aG docker $USER
      ;;
    dnf)
      installPackage docker docker-compose
      sudo systemctl enable docker
      sudo usermod -aG docker $USER
      ;;
    pacman)
      installPackage docker docker-compose
      sudo systemctl enable docker
      sudo usermod -aG docker $USER
      ;;
  esac

  # VS Code
  if ! hash code 2>/dev/null; then
    info "Installing Visual Studio Code..."
    case $PKG_MANAGER in
      apt)
        if hash snap 2>/dev/null; then
          sudo snap install code --classic
        else
          info "Install VS Code manually: https://code.visualstudio.com/docs/setup/linux"
        fi
        ;;
      *)
        info "Install VS Code manually: https://code.visualstudio.com/docs/setup/linux"
        ;;
    esac
  fi

  # Warp terminal
  info "Warp terminal: install from https://www.warp.dev/ if desired."
}

installAllLinuxPackages() {
  installMainPackages;
  installDevPackages;
}

mainMenuPackages() {
  echo "Linux Package Menu";
  echo "What would you like to do?";
  options=("Install all packages" "Install main packages" "Install dev packages" "Return to main menu")
  select opt in "${options[@]}"
  do
    case $opt in
      ${options[0]})
        installAllLinuxPackages;
      ;;
      ${options[1]})
        installMainPackages;
      ;;
      ${options[2]})
        installDevPackages;
      ;;
      ${options[3]})
        echo "Returning to main menu...";
        break 2;
      ;;
      *) echo "Invalid option";;
    esac
  done
}

mainPackages() {
  while true; do
    mainMenuPackages;
  done
}
