# ~/.zprofile -- common environment variables

# Locale
export LANG=en_US.UTF-8

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load machine-specific environment
[[ -f ~/.zprofile.local ]] && source ~/.zprofile.local
