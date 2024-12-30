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

  # Convert target to an absolute path
  local full_target_path=$(realpath "$target")

  # Check if the target file exists
  if [ -e "$full_target_path" ]; then
    if [ ! -L "$link" ]; then
      ln -s "$full_target_path" "$link"
      echo "Created symlink for $link -> $full_target_path"
    else
      echo "Symlink for $link already exists"
    fi
  else
    echo "Target $full_target_path does not exist. Skipping symlink for $link."
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
