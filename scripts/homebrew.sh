#!/bin/sh

installBrew() {
  if hash brew 2>/dev/null; then
    info "Brew already installed."
  else
    info "Installing Homebrew package manager...";
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";

    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.bash_profile
    else
      echo "not sure what shell is in use, placing it in \`~/.bash_profile\`"
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.bash_profile
      # assume something else
    fi

    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

updateBrew() {
  if hash brew 2>/dev/null; then
    info "Updating Homebrew package manager...";
    brew update;
  fi
}

installBrewDeps() {
  info "Installing Brew dependencies...";
  # Install all our dependencies with bundle (See Brewfile)
  brew tap homebrew/bundle
  brew tab homebrew/cask-versions
  brew bundle
}

installAllHomebrew() {
  installBrew;
  updateBrew;
  installBrewDeps;
}

mainMenuHomebrew() {
  echo "Homebrew Menu";
  echo "What would you like to do?";
  options=("Install all homebrew (homebrew and dependencies)" "Install just homebrew (no dependencies)" "Install just homebrew dependencies" "Return to main menu")
  select opt in "${options[@]}"
  do
    case $opt in 
      ${options[0]})
        installAllHomebrew
      ;;
      ${options[1]})
        installBrew;
        updateBrew;
      ;;
      ${options[2]})
        updateBrew;
        installBrewDeps;
      ;;
      ${options[3]})
        echo "Returning to main menu...";
        break 2;
      ;;
      *) echo "Invalid option";;
    esac
  done
}


mainHomebrew(){
  while true; do
    mainMenuHomebrew;
  done
}