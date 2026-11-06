DOTFILES="$HOME/.dotfiles"

# PATH first: omz plugins probe for their binaries at load time (the docker
# plugin runs `docker --version`), so PATH must be complete before that.
[ -r "$DOTFILES/shared/shell/exports.zsh" ] && source "$DOTFILES/shared/shell/exports.zsh"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  git
  docker
  zsh-autosuggestions
)
source "$ZSH/oh-my-zsh.sh"

# Dotfiles shell config
for f in "$DOTFILES"/shared/shell/{aliases,functions,tools}.zsh; do
  [ -r "$f" ] && source "$f"
done

# Machine-local overrides (not tracked)
[ -r "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
