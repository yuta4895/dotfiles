# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles managed with [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager) on macOS (aarch64-darwin, host `YutaMBP`).

## Apply changes

```sh
darwin-rebuild switch --flake .#YutaMBP
```

## Structure

```
flake.nix              # Entry point — inputs and darwinConfigurations
hosts/darwin/          # nix-darwin system config
home/yuta/home.nix     # home-manager user config
config/
  tmux/tmux.conf       # sourced via builtins.readFile in home.nix
  wezterm/             # symlinked to ~/.config/wezterm via xdg.configFile
  nvim/                # symlinked to ~/.config/nvim via xdg.configFile
```

## Nix architecture

**`flake.nix`** — declares inputs (`nixpkgs-unstable`, `nix-darwin`, `home-manager`) and wires them together. `home-manager` runs as a nix-darwin module with `useGlobalPkgs` and `useUserPackages` enabled.

**`hosts/darwin/default.nix`** — system-level config: `environment.systemPackages`, `nix.settings`, `programs.zsh.enable`, `users.users.yuta`.

**`home/yuta/home.nix`** — user-level config via home-manager. Programs configured here (selection):
- `programs.zsh` — shell with `profileExtra` (Homebrew init, `.zprofile.local`) and `initContent` (`_fzf_compgen_*`, `.zshrc.local`)
- `programs.fzf` — all `FZF_*` env vars and zsh integration
- `programs.starship` — prompt config inlined as `settings` attrset (no external TOML)
- `programs.tmux` — config sourced from `config/tmux/tmux.conf` via `builtins.readFile`
- `programs.git` / `programs.gh` — git identity, default branch, ghq root, SSH URL rewrite
- `programs.ssh` — disabled (`enable = false`); SSH config managed separately
- `programs.eza` — replaces `ls` with icons and git status via zsh integration
- `programs.zoxide` — `z` command with zsh integration
- `xdg.configFile."wezterm"` / `xdg.configFile."nvim"` — directory symlinks into `~/.config/`

## Neovim architecture

Config lives at `config/nvim/`, symlinked to `~/.config/nvim` by home-manager.

Entry point `init.lua` loads in order:
1. `config.options` — `vim.opt` settings
2. `config.keymaps` — global keymaps (`jk` → `<ESC>`, leader = `<Space>`)
3. `core.lazy` — bootstraps lazy.nvim, then imports all files from `lua/plugins/`

Each file in `lua/plugins/` returns a lazy.nvim plugin spec. Key plugins:
- **snacks.nvim** — picker, explorer, dashboard, notifier. Most `<leader>` keymaps route through Snacks.
- **nvim-lspconfig + mason** — LSP; mason auto-installs `lua_ls` and `pyright`. Keymaps (`gd`, `gr`, `K`, `<leader>ca`) registered via `Snacks.keymap.set`.
- **oil.nvim** — file manager; `-` opens parent dir. `C-h/j/k/l` disabled to avoid tmux navigator conflicts.
- **claudecode.nvim** — Claude Code integration; auto-starts, no terminal UI. `<leader>a` prefix.
- **vim-tmux-navigator** — `C-h/j/k/l` navigation across nvim splits and tmux panes.

## tmux

Prefix is `C-s`. Splits: `|` (horizontal), `-` (vertical). Pane navigation via vim-tmux-navigator (`C-h/j/k/l`). Config at `config/tmux/tmux.conf` — changes require `darwin-rebuild switch` to take effect.

## Machine-local overrides

Not tracked in this repo — sourced if present:
- `~/.zprofile.local` — machine-specific env vars
- `~/.zshrc.local` — machine-specific interactive shell config
- `~/.ssh/config` — SSH config
