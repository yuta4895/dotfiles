# ~/.zshrc -- interactive shell settings

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Load machine-specific interactive config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
