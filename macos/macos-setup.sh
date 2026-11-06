#!/bin/bash

copyFinickyConfig() {
  info "Copying finicky config...";
  cp "$HOME/.dotfiles/macos/.finicky.js" "$HOME/.finicky.js"
}

setupCodeAliasMac(){
  info "Setting up code alias (macOS)"
  local vscode_path='export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"'
  if ! grep -qF "Visual Studio Code" "$HOME/.zprofile" 2>/dev/null; then
    echo "" >> "$HOME/.zprofile"
    echo "# Add Visual Studio Code (code)" >> "$HOME/.zprofile"
    echo "$vscode_path" >> "$HOME/.zprofile"
  else
    info "VS Code PATH already configured in .zprofile"
  fi
}

installFontsMac(){
  info "Installing fonts (macOS)...";
  info "Copying JetBrains Mono Regular font for VS Code...";
  cp "$HOME/.dotfiles/shared/fonts/JetBrainsMono-Regular.ttf" "$HOME/Library/Fonts"
  info "Copying Meslo for Powerline font for OhMyZsh theme...";
  cp "$HOME/.dotfiles/shared/fonts/Meslo LG S DZ Regular for Powerline.ttf" "$HOME/Library/Fonts"
}

installColimaPruneAgent(){
  info "Installing colima prune launchd agent (weekly)...";
  local label="com.dotfiles.colima-prune"
  local target="$HOME/Library/LaunchAgents/$label.plist"
  mkdir -p "$HOME/Library/LaunchAgents"
  sed "s|__HOME__|$HOME|g" "$HOME/.dotfiles/macos/launchd/colima-prune.plist" > "$target"
  launchctl bootout "gui/$(id -u)/$label" 2>/dev/null
  launchctl bootstrap "gui/$(id -u)" "$target"
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
  installColimaPruneAgent;
}

mainMenuMac() {
  echo "macOS Setup Menu";
  echo "What would you like to do?";
  options=("Install Everything (macOS)" "Homebrew Menu" "Copy Finicky Config" "Setup code alias" "Install Fonts" "Install colima prune agent" "Return to main menu")
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
        installColimaPruneAgent;
      ;;
      ${options[6]})
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
