#!/bin/bash

# Dotfiles installation script

#----------------------
# Variables
#----------------------
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
dependencies=("git" "fzf" "nodejs" "npm")

#----------------------
# Functions
#----------------------
get_directories() {
    local dir="$1"
    find "$dir" -maxdepth 1 -type d -not -name ".*" -printf "%f\n" | tail -n +2
}

create_symlink() {
    local src="$1"
    local dest="$2"
    if [ -e "$dest" ]; then
        echo "Backing up existing $dest"
        mv "$dest" "${dest}.bak"
    fi
    ln -s "$src" "$dest"
    echo "Created symlink: $dest -> $src"
}

check_and_install() {
    if ! command -v $1 &> /dev/null; then
        echo "$1 is not installed. Installing..."
        sudo apt install $1
    else
        echo "$1 is already installed."
    fi
}

#----------------------
# Main Script
#----------------------
main() {
    # Create necessary directories
    mkdir -p "$CONFIG_DIR"

    # Create symlinks for all directories
    for dir in $(get_directories "$DOTFILES_DIR"); do
        create_symlink "$DOTFILES_DIR/$dir" "$CONFIG_DIR/$dir"
    done

    # Set permissions
    chmod 755 "$CONFIG_DIR"

    # Check and install dependencies
    for dep in "${dependencies[@]}"; do
        check_and_install "$dep"
    done

    echo "Dotfiles installation complete!"
}

# Run the main script
main
