# standalone home-manager, no nix-darwin.
#
# $ home-manager switch --flake .#standalone
{ ... }: {
  imports = [ ./common.nix ];

  home.username = "yuta";
  home.homeDirectory = "/Users/yuta";

  # Installs the `home-manager` CLI itself (nix-darwin provides it on YutaMBP).
  programs.home-manager.enable = true;

  # To override git settings, create ~/.gitconfig which is read after ~/.config/git.
  # Create ~/.gitconfig before switching, otherwise `git config --global` tries
  # to write to the read-only ~/.config/git/config.
}
