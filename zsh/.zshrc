# ~/.zshrc -- interactive shell settings

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--style minimal --height 40% --tmux bottom,40% --layout reverse --border top'
export FZF_CTRL_T_COMMAND='fd --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target,venv,build,dist
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
"
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target,venv,build,dist
  --preview 'tree -C {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Load machine-specific interactive config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
