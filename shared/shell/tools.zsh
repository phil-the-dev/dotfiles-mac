# mise (version manager — manages PATH itself, no shims needed)
command -v mise >/dev/null && eval "$(mise activate zsh)"

# Starship prompt
command -v starship >/dev/null && eval "$(starship init zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# VS Code shell integration (only inside VS Code terminal)
[[ "$TERM_PROGRAM" == "vscode" ]] && command -v code >/dev/null && . "$(code --locate-shell-integration-path zsh)"
