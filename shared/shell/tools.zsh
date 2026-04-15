# asdf (macOS via Homebrew, or Linux via ~/.asdf)
if [ -r /opt/homebrew/opt/asdf/libexec/asdf.sh ]; then
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
elif [ -r "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
fi

# Starship prompt
command -v starship >/dev/null && eval "$(starship init zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# VS Code shell integration (only inside VS Code terminal)
[[ "$TERM_PROGRAM" == "vscode" ]] && command -v code >/dev/null && . "$(code --locate-shell-integration-path zsh)"

# Fig export
[ -r "$HOME/fig-export/dotfiles/dotfile.zsh" ] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"
