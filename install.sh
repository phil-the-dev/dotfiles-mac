#!/bin/sh

source ./utils/logging.sh
source ./utils/homebrew.sh
source ./utils/helpers.sh

source ./main-setup/main-shell.sh
source ./dev-setup/asdf.sh
source ./dev-setup/dev-shell.sh

installAll(){
  installAllHomebrew;
  installAllAsdf;
  installAllMainShellSetup;
  installAllDevShellSetup;
}

mainMenu() {
  echo "Phil's .dotfile Menu";
  echo "What would you like to do?";
  options=("Homebrew Menu" "asdf Menu" "Main Shell Setup Menu" "Dev Shell Setup Menu" "Install Everything" "Exit")
  select opt in "${options[@]}"
  do
    case $opt in 
      ${options[0]})
        mainHomebrew;
        break;
      ;;
      ${options[1]})
        mainAsdf;
        break;
      ;;
      ${options[2]})
        mainShell;
        break;
      ;;
      ${options[3]})
        mainDevShell;
        break;
      ;;
      ${options[4]})
        installAll;
        break;
      ;;
      ${options[5]})
        exit 1;
      ;;
      *) echo "Invalid option";;
    esac
  done
}

main() {
  while true; do
    mainMenu;
  done
}

main;