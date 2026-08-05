# mise (version manager — manages PATH itself, no shims needed)
command -v mise >/dev/null && eval "$(mise activate zsh)"

# Starship prompt
command -v starship >/dev/null && eval "$(starship init zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# VS Code shell integration (only inside VS Code terminal)
[[ "$TERM_PROGRAM" == "vscode" ]] && command -v code >/dev/null && . "$(code --locate-shell-integration-path zsh)"

# npm -> aube shim. Must be prepended after `mise activate` above, which
# re-prepends its own tool bins (node's bin sits at the front of PATH) whenever
# it re-evaluates on cd. Hooking precmd here, at the end of the last sourced
# file, means this runs after mise's hook and wins. `typeset -U path` in
# exports.zsh keeps the repeated prepend idempotent.
if [ -d "$DOTFILES/shared/shell/shims" ]; then
  _dotfiles_shims_path() { export PATH="$DOTFILES/shared/shell/shims:$PATH" }
  # Once now, so `zsh -ic '...'` and anything before the first prompt get it too.
  _dotfiles_shims_path
  # Then before every prompt, to get back in front of mise after it re-prepends.
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _dotfiles_shims_path
fi
