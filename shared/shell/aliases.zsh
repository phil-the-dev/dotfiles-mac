# Git
# Untrack anything in an updated .gitignore after files were already committed.
alias gri="git ls-files --ignored --exclude-standard | xargs git rm -r"

# Go binaries
alias gbmonctl="$HOME/go/bin/gbmonctl"
