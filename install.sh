#!/bin/sh

source ./logging.sh
source ./scripts/homebrew.sh
source ./scripts/asdf.sh
source ./scripts/shell.sh

mainMenu() {
  echo "Phil's .dotfile Menu";
  echo "What would you like to do?";
  options=("Homebrew Menu" "asdf Menu" "Shell Setup Menu" "Install Everything" "Exit")
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
        mainShell
        break;
      ;;
      ${options[3]})
        installAllHomebrew;
        installAllAsdf;
        installAllShellSetup;
        break;
      ;;
      ${options[4]})
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