#!/bin/bash

createZshLink(){
  info "Linking up zshrc"
  rm -rf "$HOME/.zshrc"
  ln -s "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
}

createClaudeLink() {
  info "Linking up Claude config"
  mkdir -p "$HOME/.claude"
  rm -rf "$HOME/.claude/CLAUDE.md"
  ln -s "$HOME/.dotfiles/shared/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
  rm -rf "$HOME/.claude/settings.json"
  ln -s "$HOME/.dotfiles/shared/claude/settings.json" "$HOME/.claude/settings.json"
}

createStarshipLink() {
  info "Linking starship config"
  mkdir -p "$HOME/.config"
  rm -f "$HOME/.config/starship.toml"
  ln -s "$HOME/.dotfiles/shared/config/starship.toml" "$HOME/.config/starship.toml"
}

createRepoDirectory(){
  info "Making Home ~/Repos Directory"
  mkdir -p "$HOME/Repos"
}

installOhMyZsh() {
  if [ -d "$HOME/.oh-my-zsh" ]; then
    info "Oh My Zsh already installed."
    return 0
  fi
  info "Installing Oh My Zsh...";
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

installZshPlugins() {
  info "Installing Zsh Plugins...";
  local plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
  clone_or_pull "zsh-users/zsh-autosuggestions" "$plugin_dir"
}

installAsdf() {
  info "Installing asdf...";
  local zshrc="${ZDOTDIR:-$HOME}/.zshrc"
  if hash brew 2>/dev/null; then
    local asdf_line=". $(brew --prefix asdf)/libexec/asdf.sh"
    if ! grep -qF "asdf.sh" "$zshrc" 2>/dev/null; then
      echo -e "\n${asdf_line}" >> "$zshrc"
    else
      info "asdf already configured in .zshrc"
    fi
  elif [ -f "$HOME/.asdf/asdf.sh" ]; then
    if ! grep -qF "asdf.sh" "$zshrc" 2>/dev/null; then
      echo -e "\n. $HOME/.asdf/asdf.sh" >> "$zshrc"
    else
      info "asdf already configured in .zshrc"
    fi
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
  createStarshipLink;
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
  options=("Install Everything (shared)" "Create .zshrc symlink" "Link Claude config" "Link starship config" "Create Repo Directory" "Install Oh My Zsh" "Install Zsh Plugins" "Return to main menu")
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
        createStarshipLink;
      ;;
      ${options[4]})
        createRepoDirectory;
      ;;
      ${options[5]})
        installOhMyZsh;
      ;;
      ${options[6]})
        installZshPlugins;
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

mainShared() {
  while true; do
    mainMenuShared;
  done
}
