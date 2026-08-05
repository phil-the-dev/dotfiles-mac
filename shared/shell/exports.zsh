# Keep PATH free of duplicates, however many times entries get re-added
typeset -U path PATH

# PostgreSQL 16
[ -d /opt/homebrew/opt/postgresql@16/bin ] && export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# asdf shims
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# ~/.local/bin (Hermes Agent, q). Here rather than .zprofile so non-login
# interactive shells get it too.
export PATH="$HOME/.local/bin:$PATH"

# Docker Desktop CLI. Its /usr/local/bin symlinks are absent on this machine, and
# the omz docker plugin probes `docker --version` at load.
[ -d "/Applications/Docker.app/Contents/Resources/bin" ] && \
  export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

# Vite+ (https://viteplus.dev)
[ -r "$HOME/.vite-plus/env" ] && . "$HOME/.vite-plus/env"
