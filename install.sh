#!/bin/sh

echo "Setting up your Mac..."

echo "install homebrew"
# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.profile
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

echo "brew update"
# Update Homebrew recipes
brew update

echo "brew bundle"
# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

echo "making home repo directory"
# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir "$HOME/Development Repos"

echo "linking up zshrc"
# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Symlink the Mackup config file to the home directory
# ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

echo "reload shell"
# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
