#!/bin/sh
 
installBrew() {
  if hash brew 2>/dev/null; then
    echo "[INFO] Brew already installed."
  else
    echo "[INFO] Installing Homebrew package manager...";
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";

    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

updateBrew() {
  if hash brew 2>/dev/null; then
    echo "[INFO] Updating Homebrew package manager...";
    brew update;
  fi
}

installBrewDeps() {
  echo "[INFO] Installing Brew dependencies...";
  # Install all our dependencies with bundle (See Brewfile)
  brew tap homebrew/bundle
  brew tab homebrew/cask-versions
  brew bundle
}

installAsdf() {
  # Clone repository
  echo "[INFO] Cloning asdf repository...";
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf;

  echo '. $HOME/.asdf/asdf.sh' >> ~/.zprofile
  echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.zprofile
  source ~/.zprofile

  # Install useful plugins (at least for me :D)
  echo "[INFO] Installing asdf plugins...";
  source $HOME/.asdf/asdf.sh;

  asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git;
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
}

createRepoDirectory(){
  echo "[INFO] Making Home `~/repos` Directory"
  # This is a default directory for macOS user accounts but doesn't comes pre-installed
  mkdir "$HOME/repos"
}

createZshLink(){
  echo "[INFO] Linking up zshrc"
  # Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
  rm -rf $HOME/.zshrc
  ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
}

installOhMyZsh() {
  echo "[INFO] Installing Oh My Zsh...";
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

copyFinickyConfig() {
  echo "[INFO] Copying finicky config...";
  cp $HOME/.dotfiles/.finicky $HOME/.finicky
}

installDotFiles(){
  echo "[INFO] Installing .dotfiles"
  createZshLink;
  installBrew;
  updateBrew;
  installBrewDeps;
  installAsdf;
  createRepoDirectory;
  copyFinickyConfig;

  echo "[INFO] Reloading shell"
  # Set macOS preferences
  # We will run this last because this will reload the shell
  source .zshrc
}


if [ "$1" == "--force" -o "$1" == "-f" ]; then
  installDotFiles;
else
  read -p "I'm about to change the configuration files placed in your home directory. Do you want to continue? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    installDotFiles;
  fi;
fi;

echo "";
echo "[INFO] If there isn't any error message, the process is completed.";