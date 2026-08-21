#!/bin/bash

createZshLink(){
  info "Linking up zshrc"
  rm -rf "$HOME/.zshrc"
  ln -s "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
}

createClaudeLink() {
  info "Linking up Claude config"
  mkdir -p "$HOME/.claude"
  rm -f "$HOME/.claude/CLAUDE.md"
  ln -s "$HOME/.dotfiles/AI_SYSTEM_PROMPT.md" "$HOME/.claude/CLAUDE.md"
  rm -rf "$HOME/.claude/settings.json"
  ln -s "$HOME/.dotfiles/shared/claude/settings.json" "$HOME/.claude/settings.json"
}

createCodexLink() {
  info "Linking up Codex config"
  mkdir -p "$HOME/.codex"
  rm -f "$HOME/.codex/AGENTS.md"
  ln -s "$HOME/.dotfiles/AI_SYSTEM_PROMPT.md" "$HOME/.codex/AGENTS.md"
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

createMiseLink() {
  info "Linking mise config"
  mkdir -p "$HOME/.config/mise"
  rm -f "$HOME/.config/mise/config.toml"
  ln -s "$HOME/.dotfiles/shared/config/mise.toml" "$HOME/.config/mise/config.toml"

  # A leftover asdf-style ~/.tool-versions outranks the global config, so back it up.
  if [ -f "$HOME/.tool-versions" ]; then
    info "Backing up ~/.tool-versions -> ~/.tool-versions.bak (it would shadow mise.toml)"
    mv "$HOME/.tool-versions" "$HOME/.tool-versions.bak"
  fi
}

# Shell activation lives in shared/shell/tools.zsh, so there is no .zshrc to patch.
installMise() {
  if hash mise 2>/dev/null; then
    info "mise already installed."
    return 0
  fi
  info "Installing mise...";
  if hash brew 2>/dev/null; then
    brew install mise
  else
    curl -fsSL https://mise.run | sh
  fi
}

installMiseTools() {
  if ! hash mise 2>/dev/null; then
    error "mise not found. Install it first."
    return 1
  fi
  info "Installing global mise tools..."
  mise install
}

installAllMise() {
  installMise;
  createMiseLink;
  installMiseTools;
}

installAllSharedSetup() {
  createZshLink;
  createClaudeLink;
  createCodexLink;
  createStarshipLink;
  createRepoDirectory;
  installOhMyZsh;
  installZshPlugins;
}

mainMenuMise() {
  echo "mise Menu";
  echo "What would you like to do?";
  options=("Install everything mise" "Install just mise" "Link mise config" "Install global tools" "Return to main menu")
  select opt in "${options[@]}"
  do
    case $opt in
      ${options[0]})
        installAllMise;
      ;;
      ${options[1]})
        installMise;
      ;;
      ${options[2]})
        createMiseLink;
      ;;
      ${options[3]})
        installMiseTools;
      ;;
      ${options[4]})
        echo "Returning to main menu...";
        break 2;
      ;;
      *) echo "Invalid option";;
    esac
  done
}

mainMise() {
  while true; do
    mainMenuMise;
  done
}

mainMenuShared() {
  echo "Shared Setup Menu";
  echo "What would you like to do?";
  options=("Install Everything (shared)" "Create .zshrc symlink" "Link Claude config" "Link Codex config" "Link starship config" "Create Repo Directory" "Install Oh My Zsh" "Install Zsh Plugins" "Return to main menu")
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
        createCodexLink;
      ;;
      ${options[4]})
        createStarshipLink;
      ;;
      ${options[5]})
        createRepoDirectory;
      ;;
      ${options[6]})
        installOhMyZsh;
      ;;
      ${options[7]})
        installZshPlugins;
      ;;
      ${options[8]})
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
