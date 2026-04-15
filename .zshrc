# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  git
  docker
  zsh-autosuggestions
)
source "$ZSH/oh-my-zsh.sh"

# Dotfiles shell config
DOTFILES="$HOME/.dotfiles"
for f in "$DOTFILES"/shared/shell/{exports,aliases,functions,tools}.zsh; do
  [ -r "$f" ] && source "$f"
done

# Machine-local overrides (not tracked)
[ -r "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
