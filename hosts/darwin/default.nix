{ pkgs, self, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
    ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.yuta = {
    name = "yuta";
    home = "/Users/yuta";
  };

  homebrew = {
    enable = true;
    enableZshIntegration = true;
    user = "yuta";
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    casks = [
      "google-chrome"
      "firefox"
      "slack"
      "zoom"
      "skim"
      "obsidian"
      "zotero"
      "raycast"
      "wezterm"
      "visual-studio-code"
      "intellij-idea"
      "docker-desktop"
      "claude-code"
      "copilot-cli"
      "chatgpt"
      "google-gemini"
      "font-hack-nerd-font"
      "xquartz"
    ];
  };
}

