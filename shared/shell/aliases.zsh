# Git
# Untrack anything in an updated .gitignore after files were already committed.
alias gri="git ls-files --ignored --exclude-standard | xargs git rm -r"

# Go binaries
alias gbmonctl="$HOME/go/bin/gbmonctl"

# Node
# npm and npx are routed to aube/aubx by shims/ (wired up in tools.zsh) so that
# scripts get them too, not just interactive shells. Those shims also shadow the
# real binaries, so reach them through mise rather than `command npm`.
alias rnpm="mise exec node -- npm"
alias rnpx="mise exec node -- npx"
