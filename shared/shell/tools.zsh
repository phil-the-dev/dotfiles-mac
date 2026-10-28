# mise (version manager — manages PATH itself, no shims needed)
# Each mise exec costs ~0.3s here, so `mise activate zsh` is cached and rebuilt
# when the mise binary changes. The output embeds a PATH snapshot, so it is
# generated with a placeholder PATH that is swapped back to a live $PATH. Nested
# shells inherit mise state that only live activate output cleans up, so they
# skip the cache.
if (( $+commands[mise] )); then
  _mise_cache="${XDG_CACHE_HOME:-$HOME/.cache}/mise-activate.zsh"
  if [[ -n "$__MISE_ORIG_PATH" ]]; then
    eval "$(mise activate zsh)"
  else
    if [[ ! -s "$_mise_cache" || "$commands[mise]" -nt "$_mise_cache" ]]; then
      mkdir -p "${_mise_cache:h}"
      _mise_bindir="${commands[mise]:h}"
      env -i HOME="$HOME" PATH="@@PATH@@:$_mise_bindir" "$commands[mise]" activate zsh \
        | sed "s|'\([^']*\)@@PATH@@:$_mise_bindir'|\"\1\$PATH\"|" >| "$_mise_cache"
      unset _mise_bindir
    fi
    source "$_mise_cache"
  fi
  unset _mise_cache
fi

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
