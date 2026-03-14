#!/bin/sh

createZshLink(){
  info "Linking up zshrc"
  rm -rf $HOME/.zshrc
  ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
}

createClaudeLink() {
  info "Linking up CLAUDE.md"
  mkdir -p $HOME/.claude
  rm -rf $HOME/.claude/CLAUDE.md
  ln -s $HOME/.dotfiles/CLAUDE.md $HOME/.claude/CLAUDE.md
}

createRepoDirectory(){
  info "Making Home ~/Repos Directory"
  mkdir -p "$HOME/Repos"
}

installOhMyZsh() {
  info "Installing Oh My Zsh...";
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

installZshPlugins() {
  info "Installing Zsh Plugins...";
  clone_or_pull "zsh-users/zsh-syntax-highlighting"
}

installAsdf() {
  info "Installing asdf...";
  if hash brew 2>/dev/null; then
    echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
  elif [ -f "$HOME/.asdf/asdf.sh" ]; then
    echo -e "\n. $HOME/.asdf/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
  else
    info "asdf not found. Install it first via your package manager."
  fi
}

installAsdfPlugins() {
  info "Installing asdf plugins..."
  asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git;
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
}

installAllAsdf() {
  installAsdf;
  installAsdfPlugins;
}

installAllSharedSetup() {
  createZshLink;
  createClaudeLink;
  createRepoDirectory;
  installOhMyZsh;
  installZshPlugins;
}

mainMenuAsdf() {
  echo "asdf Menu";
  echo "What would you like to do?";
  options=("Install everything asdf" "Install just asdf" "Install just asdf plugins" "Return to main menu")
  select opt in "${options[@]}"
  do
    case $opt in
      ${options[0]})
        installAllAsdf;
      ;;
      ${options[1]})
        installAsdf;
      ;;
      ${options[2]})
        installAsdfPlugins;
      ;;
      ${options[3]})
        echo "Returning to main menu...";
        break 2;
      ;;
      *) echo "Invalid option";;
    esac
  done
}

mainAsdf() {
  while true; do
    mainMenuAsdf;
  done
}

mainMenuShared() {
  echo "Shared Setup Menu";
  echo "What would you like to do?";
  options=("Install Everything (shared)" "Create .zshrc symlink" "Create CLAUDE.md symlink" "Create Repo Directory" "Install Oh My Zsh" "Install Zsh Plugins" "Return to main menu")
  select opt in "${options[@]}"
  do
    case $opt in
      ${options[0]})
        installAllSharedSetup;
      ;;
      ${options[1]})
        createZshLink;
      ;;
      ${options[2]})
        createClaudeLink;
      ;;
      ${options[3]})
        createRepoDirectory;
      ;;
      ${options[4]})
        installOhMyZsh;
      ;;
      ${options[5]})
        installZshPlugins;
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

mainShared() {
  while true; do
    mainMenuShared;
  done
}
