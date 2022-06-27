# phil-the-dev's Dotfiles

These are my dotfiles to help me keep my development environment replicable when moving machines.

I've separated most of the scripts into 2 main groups: Dev and Main

Dev group contains scripts that are used to setup my development environment. Anything that helps my coding environment should be located here. _(examples: VS Code, OhMyZsh, Repo Directory, etc.)_

Main group contains scripts that are used to setup my main environment. Anything that helps my daily life should be located here. _(examples: Firefox, Slack, etc.)_

Homebrew is used to install most things.

## Requirements

- macOS
- zsh as your default shell

## Setup

In the command line run `./install.sh`. Everything should be menu based afterwards.

I've already run `chmod +x ./install.sh` in this repository, so that _shouldn't_ need to happen, but if you run into issues running the script, try that first.

## What's Included (and why)

Main:

- DisplayPlacer: Whenever I re-dock my laptop sometimes my displays are not setup like it was previously, this allows me to quickly re-setup my displays via command line aliases.
- Bartender: I super dislike how cluttered the system icons by the clock can be, this lets me hide ones I don't need to see all day.
- Discord: Chatting with friends and keeping up with certain communities.
- Finicky: This is a small app that allows me to redirect clicked links in Slack to a browser of my choice. Google Meet doesn't work well in Firefox, so this lets me open it in Chrome instead.
- Firefox: The main reason I like firefox is that I can have Session Tabs, so I can be logged in to the same site with different test accounts within the same window.
- Mimestream: An email client that supports Gmail super well, feels the closest I'll get to a desktop gmail application.
- Rectangle: This is a window management tool that lets me easily move and resize my windows. (i.e. 50% of the screen, 1/3 of the screen, etc.)
- Slack: This is how I chat with people at work. Will probably remove once I no longer need to chat with people at work.
- Spotify: This is my music player.
- SwitchResX: This is a better mac display app, allows me to chose custom resolutions for my displays.

Dev:

- Oh My Zsh: This is my zsh configuration tool. I use this to setup my zsh environment.
- asdf: This is a tool that can manage versions of languages/frameworks. I use it to replace `nvm` and `rvm`.
- hub: Github's CLI tool, not sure I use this much, but good to have.
- powerlevel10k: this is a zsh theme. It's neat and I like it, requires the font "Meslo LG L DZ for Powerlevel10k" to be installed. (It's included in `dev-setup/fonts` and there's a menu option to install all the fonts in the script.)
- yarn: This is a node package manager. I don't use it personally, but some projects I come across still use it.
- zsh: This is my default shell. I install it via homebrew, but I _think_ macOS has this by default now.
- docker: Allows me to run docker containers. I also like the Docker Desktop to manage my docker containers. (not much of a terminal user)
- fork: A Git application when I can't use VS Code's git integration reliably. Mostly used for reverting, cherry picking, amending commits, and viewing the log/history.
- fig: Intellisense for the terminal, it's great!
- figma: This is a design tool. I don't use it much, but the designers at work use it, so I use it to view more than designing.
- iterm2: A better terminal app that Terminal.
- raycast: a Spotlight/Alfred replacement. I have a configuration file also in this repo to import after installation.
- VS Code: This is my main editor of choice. I use it for all my coding.
