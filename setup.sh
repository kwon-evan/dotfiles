#!/bin/bash

# function: Check if command is installed
is_installed() {
    if ! command -v $1 &> /dev/null; then
        echo "[INFO] $1 not found"
        return 1
    else
        echo "[INFO] $1 already installed"
        return 0
    fi
}

# function: Install starship
install_starship() {
    if is_installed starship; then
        return
    fi
    echo "[INFO] Installing starship..."
    curl -fsSL https://starship.rs/install.sh | $SHELL
}

# function: Install brew
install_brew() {
    if is_installed brew; then
        return
    fi

    echo "[INFO] Installing brew..."
    $SHELL -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# function: Install neovim
install_neovim() {
    if is_installed nvim; then
        return
    fi

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if is_installed snap; then
            sudo snap install nvim --classic
        elif is_installed apt; then
            sudo apt install neovim
        else
            echo "[ERROR] OS not supported"
            exit 1
        fi

    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if ! is_installed brew; then
            install_brew
        fi

        brew install neovim
    else
        echo "[ERROR] OS not supported"
        exit 1
    fi
}

# function: Create symbolic link
link_config() {
  CONFIG_PATH="${HOME}/.config"
  if [ -e "${CONFIG_PATH}/$1" ]; then
    echo "[INFO] $1 already exists"
  else
    ln -s ${PWD}/$1 ${CONFIG_PATH}/$1
  fi
}

# Install
echo "[INFO] Install..."
install_starship
install_neovim

# Link
echo "[INFO] Link config..."
link_config nvim
link_config starship.toml
link_config yazi
