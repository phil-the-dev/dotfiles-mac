#!/bin/sh

createZshLink(){
  info "Linking up zshrc"
  # Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
  rm -rf $HOME/.zshrc
  ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
}

copyFinickyConfig() {
  info "Copying finicky config...";
  cp $HOME/.dotfiles/.finicky.js $HOME/.finicky.js
}

installMainBrewDeps() {
  installBrewDeps "./main-setup/Brewfile";
}

installAllMainShellSetup() {
  installMainBrewDeps;
  createZshLink;
  copyFinickyConfig;
}

mainMenuShell() {
  echo "Shell Setup Menu";
  echo "What would you like to do?";
  options=("Install Everything" "Install Main Homebrew dependencies" "Create .zshrc symlink" "Copy Finicky Config" "Return to main menu")
  select opt in "${options[@]}"
  do
    case $opt in 
      ${options[0]})
        installAllMainShellSetup;
      ;;
      ${options[1]})
        installMainBrewDeps;
      ;;
      ${options[2]})
        createZshLink;
      ;;
      ${options[3]})
        copyFinickyConfig;
      ;;
      ${options[4]})
        echo "Returning to main menu...";
        break 2;
      ;;
      *) echo "Invalid option";;
    esac
    break;
  done
}

mainShell() {
  while true; do
    mainMenuShell;
  done
}