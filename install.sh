#!/bin/bash

# Make sure we are in the home directory
cd ~

# Clone the dotfiles repository
git clone https://github.com/USERNAME/dotfiles.git

# Create a backup directory for existing dotfiles
mkdir dotfiles-backup

# Move any existing dotfiles to the backup directory
mv .bashrc dotfiles-backup/
mv .vimrc dotfiles-backup/
mv .tmux.conf dotfiles-backup/
mv .config/fish/config.fish dotfiles-backup/

# Create symlinks for the dotfiles in the repository
ln -s dotfiles/.bashrc .bashrc
ln -s dotfiles/.vimrc .vimrc
ln -s dotfiles/.tmux.conf .tmux.conf
ln -s dotfiles/.config/fish/config.fish .config/fish/config.fish
