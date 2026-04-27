# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Overview

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory (`nvim`, `tmux`, `wezterm`, `starship`, `zsh`, `nix`) mirrors the structure under `$HOME`, so `stow <tool>` from the repo root creates symlinks.

## Applying configs

```sh
# Symlink a single tool's config
stow nvim

# Remove symlinks
stow -D nvim
```

## Neovim architecture

Entry point: `nvim/.config/nvim/init.lua` loads three modules in order:

1. `config.options` — global options
2. `config.keymaps` — global keymaps
3. `core.lazy` — bootstraps and configures lazy.nvim, then imports all files from `lua/plugins/`

Each file in `lua/plugins/` returns a lazy.nvim plugin spec.

Key plugins and their roles:
- **snacks.nvim** (`plugins/snacks.lua`) — picker (file/grep/buffer search), explorer, dashboard, notifier, and many UI utilities. Most `<leader>` keymaps route through Snacks.
- **nvim-lspconfig + mason** (`plugins/lsp.lua`, `plugins/mason.lua`) — LSP setup; mason auto-installs `lua_ls` and `pyright`. LSP keymaps (`gd`, `gr`, `K`, `<leader>ca`, etc.) are registered via `Snacks.keymap.set`.
- **oil.nvim** (`plugins/oil.lua`) — file manager replacing netrw; `-` opens parent directory. `C-h/j/k/l` disabled to avoid tmux navigator conflicts.
- **claudecode.nvim** (`plugins/ai.lua`) — Claude Code integration; auto-starts, no terminal UI. `<leader>a` prefix for AI actions.
- **vim-tmux-navigator** — seamless `C-h/j/k/l` navigation between nvim splits and tmux panes.

## Shell

`zsh/.zprofile` — environment variables, Homebrew init, sources `~/.zprofile.local` for machine-specific env.

`zsh/.zshrc` — interactive config: Starship prompt, fzf bindings (using `fd` as backend), sources `~/.zshrc.local` for machine-specific interactive settings.

## tmux

Prefix is `C-s`. Pane splits: `|` (horizontal), `-` (vertical). `C-h/j/k/l` handled by vim-tmux-navigator integration.
