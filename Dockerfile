FROM ubuntu:latest
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y curl git zsh sudo
RUN chmod +x ./install.sh
# Note: install.sh is interactive (menu-based).
# For automated testing, source the scripts and call functions directly:
# RUN . ./shared/utils/logging.sh && . ./linux/packages.sh && installDevPackages
