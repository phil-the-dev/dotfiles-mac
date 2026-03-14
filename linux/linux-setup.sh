#!/bin/bash

setupCodeAliasLinux(){
  info "Setting up code alias (Linux)"
  if hash code 2>/dev/null; then
    info "VS Code 'code' command already available on PATH."
  else
    info "VS Code not found on PATH. Install it first, then 'code' will be available."
  fi
}

installFontsLinux(){
  info "Installing fonts (Linux)...";
  local font_dir="$HOME/.local/share/fonts"
  mkdir -p "$font_dir"
  info "Copying JetBrains Mono Regular font for VS Code...";
  cp $HOME/.dotfiles/shared/fonts/JetBrainsMono-Regular.ttf "$font_dir/"
  info "Copying Meslo for Powerline font for OhMyZsh theme...";
  cp "$HOME/.dotfiles/shared/fonts/Meslo LG S DZ Regular for Powerline.ttf" "$font_dir/"
  info "Refreshing font cache...";
  fc-cache -fv
}

installPowerlevel10kLinux() {
  info "Installing powerlevel10k..."
  local p10k_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  if [ -d "$p10k_dir" ]; then
    info "powerlevel10k already installed."
  else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
  fi
}

installAllLinuxSetup() {
  installAllLinuxPackages;
  setupCodeAliasLinux;
  installFontsLinux;
  installPowerlevel10kLinux;
}

mainMenuLinux() {
  echo "Linux Setup Menu";
  echo "What would you like to do?";
  options=("Install Everything (Linux)" "Package Manager Menu" "Setup code alias" "Install Fonts" "Install powerlevel10k" "Return to main menu")
  select opt in "${options[@]}"
  do
    case $opt in
      ${options[0]})
        installAllLinuxSetup;
      ;;
      ${options[1]})
        mainPackages;
        break;
      ;;
      ${options[2]})
        setupCodeAliasLinux;
      ;;
      ${options[3]})
        installFontsLinux;
      ;;
      ${options[4]})
        installPowerlevel10kLinux;
      ;;
      ${options[5]})
        echo "Returning to main menu...";
        break 2;
      ;;
      *) echo "Invalid option";;
    esac
    break;
  done
}

mainLinux() {
  while true; do
    mainMenuLinux;
  done
}
