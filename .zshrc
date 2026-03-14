ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time)

plugins=(
  git
  docker
  zsh-syntax-highlighting
)

# Source custom function files
source $HOME/.dotfiles/shared/docker-functions.sh
source $HOME/.dotfiles/shared/zsh-functions.sh

# Changed your .gitignore _after_ you have added / committed some files?
# run `gri` to untrack anything in your updated .gitignore
# Put this in your .zshrc file
alias gri="git ls-files --ignored --exclude-standard | xargs -0 git rm -r"