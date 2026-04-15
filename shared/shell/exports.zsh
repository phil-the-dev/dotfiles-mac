# PostgreSQL 16
[ -d /opt/homebrew/opt/postgresql@16/bin ] && export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# asdf shims
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Vite+ (https://viteplus.dev)
[ -r "$HOME/.vite-plus/env" ] && . "$HOME/.vite-plus/env"
