is_installed() {
    if ! command -v $1 &> /dev/null; then
        echo "[INFO] $1 not found"
        return 1
    else
        echo "[INFO] $1 already installed"
        return 0
    fi
}

install_starship() {
    if is_installed starship; then
        return
    fi
    echo "[INFO] Installing starship..."
    curl -fsSL https://starship.rs/install.sh | $SHELL
}

install_brew() {
    if is_installed brew; then
        return
    fi

    echo "[INFO] Installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_neovim() {
    if is_installed nvim; then
        return
    fi

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if is_installed snap; then
            sudo snap install nvim --classic
        elif is_installed apt; then
            sudo apt install neovim
        elif is_installed pacman; then
            sudo pacman -S neovim
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


CONFIG_PATH="${HOME}/.config"

install_starship
install_neovim

# Clone NvChad
if [ -e "${CONFIG_PATH}/nvim" ]; then
    echo "[INFO] NvChad already exists"
else
    git clone https://github.com/NvChad/NvChad ${CONFIG_PATH}/nvim --depth 1
fi

# link config
if [ -e "${CONFIG_PATH}/nvim/lua/custom" ]; then
    echo "[INFO] nvchad_config already exists"
else
    ln -s ${PWD}/nvchad_config ${CONFIG_PATH}/nvim/lua/custom
fi

# link starship config
if [ -e "${CONFIG_PATH}/starship.toml" ]; then
    echo "[INFO] starship.toml already exists"
else
    ln -s ${PWD}/starship.toml ${CONFIG_PATH}/starship.toml
fi

# link yazi config
if [ -e "${CONFIG_PATH}/yazi" ]; then
    echo "[INFO] yazi config already exists"
else
    ln -s ${PWD}/yazi ${CONFIG_PATH}/yazi
fi

# link wezterm config
if [ -e "${CONFIG_PATH}/wezterm" ]; then
    echo "[INFO] wezterm already exists"
else
    ln -s ${PWD}/wezterm ${CONFIG_PATH}/wezterm
fi
