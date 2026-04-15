# phil-the-dev's Dotfiles

These are my dotfiles to help me keep my development environment replicable when moving machines.

## Supported Platforms

- **macOS** (primary) — uses Homebrew for package management
- **Linux** (Ubuntu/Debian, Fedora, Arch) — uses apt, dnf, or pacman

## Directory Structure

```
.zshrc                 # Slim entry point: loads OMZ + sources shared/shell/*.zsh

shared/                # Cross-platform
  shell/               # Sourced from .zshrc in order:
    exports.zsh        #   PATH and env vars
    aliases.zsh        #   Shell aliases
    functions.zsh      #   Shell functions
    tools.zsh          #   Third-party tool init (starship, asdf, bun, etc.)
  config/              # Tool configs symlinked into ~/.config/
    starship.toml
  utils/               # Logging and helper functions
  fonts/               # TTF fonts (JetBrains Mono, Meslo Powerline)
  shell-setup.sh       # Zsh + starship + CLAUDE.md symlinks, OMZ, plugins

macos/                 # macOS-specific setup
  homebrew.sh          # Homebrew install and management
  macos-setup.sh       # Finicky, fonts (~/Library/Fonts), VS Code alias
  main/Brewfile        # Main apps (Discord, Slack, Firefox, etc.)
  dev/Brewfile         # Dev tools (Docker, VS Code, iTerm2, starship, etc.)

linux/                 # Linux-specific setup
  packages.sh          # apt/dnf/pacman package installation
  linux-setup.sh       # Fonts (~/.local/share/fonts), VS Code, starship
```

### Machine-local overrides

`.zshrc` sources `~/.zshrc.local` at the end if it exists. Put machine-specific or private config (work-only helpers, per-machine secrets, etc.) there — it is outside the repo and never tracked.

Scripts are organized into **Shared**, **Main**, and **Dev** groups:

- **Shared** — cross-platform shell setup: .zshrc symlink, Oh My Zsh, zsh plugins, asdf, CLAUDE.md symlink, repo directory creation.
- **Main** — daily-use apps (Firefox, Slack, Discord, Spotify, etc.)
- **Dev** — development tools (Docker, VS Code, terminal emulators, fonts, etc.)

## Requirements

- zsh as your default shell
- macOS or a supported Linux distro (Ubuntu/Debian, Fedora, or Arch)

## Setup

```bash
./install.sh
```

The script will detect your OS (with a chance to override) and present a menu for installing everything or individual components.

## What's Included (and why)

### Shared (both platforms)

- Oh My Zsh: Zsh configuration framework
- starship: Minimal, fast, cross-shell prompt. Config lives at `shared/config/starship.toml` and is symlinked to `~/.config/starship.toml`
- asdf: Version manager for Ruby, Node.js, etc. Replaces `nvm` and `rvm`
- zsh-autosuggestions: Fish-style command suggestions in the terminal
- Docker functions: Helper aliases for docker-compose workflows (in `shared/shell/functions.zsh`)

### macOS-only

- DisplayPlacer: Re-setup display positions via command line aliases
- Bartender: Hide cluttered menu bar icons
- Discord, Slack, Spotify: Chat and music
- Finicky: Redirect clicked links to specific browsers (e.g., Google Meet to Chrome)
- Firefox Developer Edition: Session tabs for multi-account testing
- Mimestream: Gmail desktop client
- Rectangle: Window management (50%, 1/3, etc.)
- SwitchResX: Custom display resolutions
- hub: GitHub CLI
- docker: Docker Desktop for Mac
- fork: Git GUI for reverting, cherry-picking, history
- warp: Modern terminal with AI features
- figma: Design tool
- iterm2: Terminal emulator
- raycast: Spotlight/Alfred replacement
- VS Code: Code editor

### Linux-only

- Packages installed via apt/dnf/pacman depending on distro
- Docker via native packages (docker.io / docker)
- VS Code via snap or manual install
- Fonts installed to `~/.local/share/fonts`
- starship installed via the official installer (`curl -sS https://starship.rs/install.sh | sh`)

## Dockerfile

The `Dockerfile` in the root is a work in progress for testing the Linux installation path in an isolated Ubuntu container. Since `install.sh` is interactive, the Dockerfile sets up dependencies but doesn't run the full installer automatically.
