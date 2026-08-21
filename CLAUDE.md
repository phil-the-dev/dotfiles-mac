# Dotfiles Repo

This repo manages Phil's dotfiles for macOS and Linux.

## Structure
- `shared/` — cross-platform config (shell, Claude, starship, fonts)
- `macos/` — macOS-specific setup and Homebrew
- `linux/` — Linux-specific setup and packages
- `install.sh` — interactive setup script

## Global AI Instructions
`AI_SYSTEM_PROMPT.md` is symlinked to `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md` at install time.
