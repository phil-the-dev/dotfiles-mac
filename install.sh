#!/bin/bash
set -e

# Source shared utilities
source ./shared/utils/logging.sh
source ./shared/utils/helpers.sh
source ./shared/shell-setup.sh

# Detect operating system
detectOS() {
  case "$(uname -s)" in
    Darwin) DETECTED_OS="macos" ;;
    Linux)  DETECTED_OS="linux" ;;
    *)      DETECTED_OS="unknown" ;;
  esac
}

# Prompt user to confirm or change detected OS
confirmOS() {
  detectOS

  if [ "$DETECTED_OS" = "macos" ]; then
    echo "🍎 Detected: macOS"
  elif [ "$DETECTED_OS" = "linux" ]; then
    echo "🐧 Detected: Linux"
  else
    echo "❓ Could not detect your operating system."
  fi

  echo ""
  echo "Is this correct?"
  options=("Yes, continue" "Switch to macOS" "Switch to Linux" "Exit")
  select opt in "${options[@]}"
  do
    case $opt in
      ${options[0]})
        break;
      ;;
      ${options[1]})
        DETECTED_OS="macos"
        echo "Switched to macOS."
        break;
      ;;
      ${options[2]})
        DETECTED_OS="linux"
        echo "Switched to Linux."
        break;
      ;;
      ${options[3]})
        exit 0;
      ;;
      *) echo "Invalid option";;
    esac
  done

  # Source platform-specific scripts
  if [ "$DETECTED_OS" = "macos" ]; then
    source ./macos/homebrew.sh
    source ./macos/macos-setup.sh
  elif [ "$DETECTED_OS" = "linux" ]; then
    source ./linux/packages.sh
    source ./linux/linux-setup.sh
  fi
}

# Install everything for the detected platform
installAll(){
  installAllSharedSetup;
  installAllAsdf;
  if [ "$DETECTED_OS" = "macos" ]; then
    installAllMacSetup;
  elif [ "$DETECTED_OS" = "linux" ]; then
    installAllLinuxSetup;
  fi
}

mainMenu() {
  echo ""
  echo "Phil's .dotfile Menu";

  if [ "$DETECTED_OS" = "macos" ]; then
    echo "Platform: macOS 🍎";
  else
    echo "Platform: Linux 🐧";
  fi

  echo "What would you like to do?";

  if [ "$DETECTED_OS" = "macos" ]; then
    options=("Shared Setup Menu" "macOS Setup Menu" "Homebrew Menu" "asdf Menu" "Install Everything" "Exit")
  else
    options=("Shared Setup Menu" "Linux Setup Menu" "Package Manager Menu" "asdf Menu" "Install Everything" "Exit")
  fi

  select opt in "${options[@]}"
  do
    case $opt in
      ${options[0]})
        mainShared;
        break;
      ;;
      ${options[1]})
        if [ "$DETECTED_OS" = "macos" ]; then
          mainMac;
        else
          mainLinux;
        fi
        break;
      ;;
      ${options[2]})
        if [ "$DETECTED_OS" = "macos" ]; then
          mainHomebrew;
        else
          mainPackages;
        fi
        break;
      ;;
      ${options[3]})
        mainAsdf;
        break;
      ;;
      ${options[4]})
        installAll;
        break;
      ;;
      ${options[5]})
        exit 0;
      ;;
      *) echo "Invalid option";;
    esac
  done
}

main() {
  confirmOS;
  while true; do
    mainMenu;
  done
}

main;
