#!/bin/bash

# Ensure we are in the home directory
cd ~

# Clone or update the dotfiles repository
if [ ! -d "dotfiles" ]; then
  git clone https://github.com/duonkha/dotfiles.git
  echo "Cloned dotfiles repository."
else
  cd dotfiles
  git pull origin main  # Pull latest changes
  echo "Updated dotfiles repository."
  cd ..
fi

# Create a backup directory for existing dotfiles if it doesn't exist
BACKUP_DIR="dotfiles-backup"
mkdir -p "$BACKUP_DIR"

# Function to move file to backup if it exists
backup_file() {
  local file=$1
  if [ -e "$file" ]; then
    mv "$file" "$BACKUP_DIR/"
    echo "Moved existing $file to $BACKUP_DIR"
  fi
}

# Function to create a symlink if it doesn't already exist
create_symlink() {
  local target=$1
  local link=$2
  if [ ! -L "$link" ]; then
    ln -s "$target" "$link"
    echo "Created symlink for $link"
  else
    echo "Symlink for $link already exists"
  fi
}

# Back up and link each dotfile
backup_file ".bashrc"
backup_file ".vimrc"
backup_file ".tmux.conf"
backup_file ".config/fish/config.fish"

create_symlink "dotfiles/.bashrc" ".bashrc"
create_symlink "dotfiles/.vimrc" ".vimrc"
create_symlink "dotfiles/.tmux.conf" ".tmux.conf"
create_symlink "dotfiles/.config/fish/config.fish" ".config/fish/config.fish"

echo "Dotfiles setup complete with the latest version."
