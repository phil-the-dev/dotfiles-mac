# Git
# Untrack anything in an updated .gitignore after files were already committed.
alias gri="git ls-files --ignored --exclude-standard | xargs git rm -r"

# Go binaries
alias gbmonctl="$HOME/go/bin/gbmonctl"

# Docker
alias dc='docker compose'
alias -g dc_rspec="./tools/tests.sh -b"
alias -g dc_rspec_all="./tools/tests.sh -a"
