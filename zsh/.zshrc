# ~/.zshrc -- interactive shell settings

# Starship
eval "$(starship init zsh)"

# Load machine-specific interactive config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
