#!/bin/sh

echo "Setting up your Mac..."

echo "[INFO] Installing Oh My Zsh...";
curl -L http://install.ohmyz.sh | sh

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
  brew bundle
}

installAsdf() {
  # Clone repository
  echo "[INFO] Cloning asdf repository...";
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf;

  echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
  echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
  source ~/.bashrc

  # Install useful plugins (at least for me :D)
  echo "[INFO] Installing asdf plugins...";
  source $HOME/.asdf/asdf.sh;

  asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git;
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
}

createRepoDirectory(){
  echo "making home repo directory"
  # This is a default directory for macOS user accounts but doesn't comes pre-installed
  mkdir "$HOME/repos"
}

createZshLink(){
  echo "linking up zshrc"
  # Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
  rm -rf $HOME/.zshrc
  ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
}

installDotFiles(){
  echo "installing dotfiles"
  installBrew;
  updateBrew;
  installBrewDeps;
  installAsdf;
  createRepoDirectory;
  createZshLink;

  echo "reload shell"
  # Set macOS preferences
  # We will run this last because this will reload the shell
  source .macos
}
