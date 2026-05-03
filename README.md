# dotfiles

Personal system configuration managed with [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

## Structure

```
flake.nix              # Entry point — inputs and darwinConfigurations
hosts/darwin/          # nix-darwin system config (packages, defaults, users)
home/yuta/home.nix     # home-manager config (programs, shell, dotfiles)
config/
  tmux/tmux.conf       # tmux config (sourced via readFile)
  wezterm/             # WezTerm config (symlinked to ~/.config/wezterm)
  nvim/                # Neovim config (symlinked to ~/.config/nvim)
```

## Prerequisites

1. Install Nix with flakes enabled (follow https://github.com/NixOS/nix-installer):
   ```sh
   curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --enable-flakes
   ```

2. Homebrew has to be installed manually.

## Apply changes

```sh
# Run this for the first time
nix run nix-darwin/master#darwin-rebuild -- build --flake .#YutaMBP
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#YutaMBP
```

```sh
darwin-rebuild build --flake .
darwin-rebuild switch --flake .#YutaMBP
```

## Machine-local overrides

Files sourced if present — not tracked in this repo:

| File | Purpose |
|---|---|
| `~/.zprofile.local` | Machine-specific env vars |
| `~/.zshrc.local` | Machine-specific interactive shell config |
| `~/.ssh/config`   | SSH config                                |
