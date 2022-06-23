#!/bin/sh

installAsdf() {
  info "Installing asdf...";
  echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
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