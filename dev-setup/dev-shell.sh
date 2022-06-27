#!/bin/sh

createRepoDirectory(){
  info "Making Home `~/Repos` Directory"
  mkdir "$HOME/Repos"
}

installOhMyZsh() {
  info "Installing Oh My Zsh...";
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

installZshPlugins() {
  info "Installing Zsh Plugins...";
  clone_or_pull "zsh-users/zsh-syntax-highlighting"
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

installDevBrewDeps() {
  installBrewDeps "./dev-setup/Brewfile";
}

installAllDevShellSetup() {
  createRepoDirectory;
  installDevBrewDeps;
  installOhMyZsh;
  installZshPlugins;
  setupCodeAlias;
  installFonts;
}

mainMenuDevShell() {
  echo "Shell Setup Menu";
  echo "What would you like to do?";
  options=("Install Everything" "Create Repo Directory" "Install Dev Homebrew dependencies" "Install Oh My Zsh" "Install Zsh Plugins/Themes" "Setup code alias" "Install Fonts" "Return to main menu")
  select opt in "${options[@]}"
  do
    case $opt in 
      ${options[0]})
        installAllDevShellSetup;
      ;;
      ${options[1]})
        createRepoDirectory;
      ;;
      ${options[2]})
        installDevBrewDeps;
      ;;
      ${options[3]})
        installOhMyZsh;
      ;;
      ${options[4]})
        installZshPlugins;
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

mainDevShell() {
  while true; do
    mainMenuDevShell;
  done
}