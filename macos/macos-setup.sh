#!/bin/sh

copyFinickyConfig() {
  info "Copying finicky config...";
  cp $HOME/.dotfiles/macos/.finicky.js $HOME/.finicky.js
}

setupCodeAliasMac(){
  info "Setting up code alias (macOS)"
  cat << EOF >> ~/.zprofile
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF
}

installFontsMac(){
  info "Installing fonts (macOS)...";
  info "Copying JetBrains Mono Regular font for VS Code...";
  cp $HOME/.dotfiles/shared/fonts/JetBrainsMono-Regular.ttf $HOME/Library/Fonts
  info "Copying Meslo for Powerline font for OhMyZsh theme...";
  cp "$HOME/.dotfiles/shared/fonts/Meslo LG S DZ Regular for Powerline.ttf" $HOME/Library/Fonts
}

installMainBrewDeps() {
  installBrewDeps "./macos/main/Brewfile";
}

installDevBrewDeps() {
  installBrewDeps "./macos/dev/Brewfile";
}

installAllMacSetup() {
  installAllHomebrew;
  copyFinickyConfig;
  setupCodeAliasMac;
  installFontsMac;
}

mainMenuMac() {
  echo "macOS Setup Menu";
  echo "What would you like to do?";
  options=("Install Everything (macOS)" "Homebrew Menu" "Copy Finicky Config" "Setup code alias" "Install Fonts" "Return to main menu")
  select opt in "${options[@]}"
  do
    case $opt in
      ${options[0]})
        installAllMacSetup;
      ;;
      ${options[1]})
        mainHomebrew;
        break;
      ;;
      ${options[2]})
        copyFinickyConfig;
      ;;
      ${options[3]})
        setupCodeAliasMac;
      ;;
      ${options[4]})
        installFontsMac;
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

mainMac() {
  while true; do
    mainMenuMac;
  done
}
