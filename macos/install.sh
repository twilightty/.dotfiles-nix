#!/bin/zsh

# Install nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Clone the repo
git clone git@github.com:emladevops/.dotfiles-nix.git

# ...
