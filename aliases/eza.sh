# Base eza options
EZA_BASE="eza -F --icons --git --group-directories-first"

# eza aliases
alias ls="$EZA_BASE -alg"
alias lt="$EZA_BASE -alg --tree --level=2"
alias ll="$EZA_BASE -alg --time-style=long-iso"
alias la="$EZA_BASE -alg"
alias l="$EZA_BASE -l --no-user --no-time"
alias :q='exit'
