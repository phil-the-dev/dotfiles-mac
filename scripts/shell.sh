#!/bin/sh

createRepoDirectory(){
  info "Making Home `~/Repos` Directory"
  # This is a default directory for macOS user accounts but doesn't comes pre-installed
  mkdir "$HOME/Repos"
}

createZshLink(){
  info "Linking up zshrc"
  # Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
  rm -rf $HOME/.zshrc
  ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
}

installOhMyZsh() {
  info "Installing Oh My Zsh...";
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

copyFinickyConfig() {
  info "Copying finicky config...";
  cp $HOME/.dotfiles/.finicky.js $HOME/.finicky.js
}

setupCodeAlias(){
  info "Setting up `code` alias"
  cat << EOF >> ~/.zprofile
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF
}

installFonts(){
  info "Installing fonts...";
  info "Copying JetBrains Mono Regular font for VS Code...";
  cp ./fonts/JetBrainsMono-Regular.ttf $HOME/Library/Fonts
  info "Copying Meslo for Powerline font for OhMyZsh theme...";
  cp "./fonts/Meslo LG S DZ Regular for Powerline.ttf" $HOME/Library/Fonts
}

installAllShellSetup() {
  createRepoDirectory;
  createZshLink;
  installOhMyZsh;
  copyFinickyConfig;
  setupCodeAlias;
  installFonts;
}

mainMenuShell() {
  echo "Shell Setup Menu";
  echo "What would you like to do?";
  options=("Install Everything" "Create Repo Directory" "Create .zshrc symlink" "Install Oh My Zsh", "Copy Finicky Config", "Setup code alias", "Install Fonts" "Return to main menu")
  select opt in "${options[@]}"
  do
    case $opt in 
      ${options[0]})
        installAllShellSetup;
      ;;
      ${options[1]})
        createRepoDirectory;
      ;;
      ${options[2]})
        createZshLink;
      ;;
      ${options[3]})
        installOhMyZsh;
      ;;
      ${options[4]})
        copyFinickyConfig;
      ;;
      ${options[5]})
        setupCodeAlias;
      ;;
      ${options[6]})
        installFonts;
      ;;
      ${options[7]})
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