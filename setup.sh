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

add_aliases() {
    local rc_file=""
    local shell_name=$(basename "$SHELL")

    case "$shell_name" in
        bash)
            rc_file="$HOME/.bashrc"
            ;;
        zsh)
            rc_file="$HOME/.zshrc"
            ;;
        fish)
            rc_file="$HOME/.config/fish/config.fish"
            ;;
        *)
            echo "Unsupported shell: $shell_name"
            return 1
            ;;
    esac

    if [ -f "$rc_file" ]; then
        if ! grep -q "Source aliases from dotfiles" "$rc_file"; then
            echo "" >> "$rc_file"
            echo "# Source aliases from dotfiles" >> "$rc_file"
            echo "for alias_file in ~/dotfiles/aliases/*.sh; do" >> "$rc_file"
            echo "    [ -r \"\$alias_file\" ] && . \"\$alias_file\"" >> "$rc_file"
            echo "done" >> "$rc_file"
            echo "Aliases sourcing has been added to $rc_file"
        else
            echo "Aliases sourcing is already in $rc_file"
        fi
    else
        echo "RC file $rc_file does not exist"
        return 1
    fi
}

set_default_editor() {
  local editor="nvim"
  local shell_name=$(basename "$SHELL")

  case "$shell_name" in
    bash)
      rc_file="$HOME/.bashrc"
      ;;
    zsh)
      rc_file="$HOME/.zshrc"
      ;;
    fish)
      rc_file="$HOME/.config/fish/config.fish"
      ;;
    *)
      echo "Unsupported shell: $shell_name"
      return 1
      ;;
  esac

  if [ -f "$rc_file"]; then
    if ! grep -q "export EDITOR" "$rc_file"; then
      echo "export EDITOR=$editor" >> "$rc_file"
      echo "Editor set to $editor in $rc_file"
    else
      echo "Editor is already set in $rc_file"
    fi
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

    add_aliases

    set_default_editor

    echo "Dotfiles installation complete!"
}

# Run the main script
main
