# ~/.zprofile -- common environment variables

# Locale
export LANG=en_US.UTF-8

# Starship config
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load machine-specific environment
[[ -f ~/.zprofile.local ]] && source ~/.zprofile.local
