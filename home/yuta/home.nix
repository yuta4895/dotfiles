{ pkgs, self, ... }: {
  home.username = "yuta";
  home.homeDirectory = "/Users/yuta";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
  };

  home.packages = with pkgs; [
    ripgrep
    jq
    wget
    eza
    fd
    tree
    rsync
    stow
    neovim
  ];

  programs.ssh = {
    enable = true;
    includes = [ "~/.ssh/config_local" ];
    matchBlocks = {
      "github.com" = {
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/id_ed25519";
        extraOptions.UseKeychain = "yes";
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "yuta";
        email = "127702675+yuta4895@users.noreply.github.com";
      };
      init.defaultBranch = "main";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  }

  programs.tmux = {
    enable = true;
    mouse = true;
    shortcut = "s";
    keyMode = "vi";
    extraConfig = builtins.readFile ../../config/tmux/tmux.conf;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -a";
    };
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      [[ -f ~/.zprofile.local ]] && source ~/.zprofile.local
    '';
    initContent = ''
      _fzf_compgen_path() {
        fd --hidden --follow --exclude ".git" . "$1"
      }
      _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
      }
      [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --strip-cwd-prefix --hidden --follow --exclude .git";
    defaultOptions = [
      "--style minimal"
      "--height 40%"
      "--tmux bottom,40%"
      "--layout reverse"
      "--border top"
    ];
    fileWidgetCommand = "fd --strip-cwd-prefix --hidden --follow --exclude .git";
    fileWidgetOptions = [
      "--walker-skip .git,node_modules,target,venv,build,dist"
      "--preview 'bat -n --color=always {}'"
      "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
    ];
    changeDirWidgetCommand = "fd --type d --strip-cwd-prefix --hidden --follow --exclude .git";
    changeDirWidgetOptions = [
      "--walker-skip .git,node_modules,target,venv,build,dist"
      "--preview 'tree -C {}'"
      "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
    ];
    historyWidgetOptions = [
      "--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
      "--color header:italic"
      "--header 'Press CTRL-Y to copy command into clipboard'"
    ];
  };

  programs.bat = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$directory\${custom.git_indicator}  $git_branch$git_status$line_break$character";
      add_newline = true;
      palette = "gruvbox";

      directory = {
        style = "bold fg:dir_color";
        format = "[$path ]($style)";
        truncate_to_repo = false;
        substitutions = {
          "Documents" = "󰈙";
          "Downloads" = "";
          "Music" = "";
          "Pictures" = "";
        };
      };

      custom.git_indicator = {
        when = "git rev-parse --is-inside-work-tree 2>/dev/null";
        command = ''echo ""'';
        format = "[$output]($style)";
        style = "bold fg:git_color";
      };

      git_branch = {
        style = "fg:git_color";
        always_show_remote = true;
        symbol = " ";
        format = "[$symbol$branch(:$remote_branch)]($style)";
      };

      git_status = {
        style = "fg:git_color";
        format = '' [\($all_status$ahead_behind\)]($style)'';
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
        up_to_date = "✓";
      };

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      palettes.nord = {
        dir_color = "#5E81AC";
        git_color = "#B48EAD";
      };
      palettes.gruvbox = {
        dir_color = "#d79921";
        git_color = "#fe8019";
      };
    };
  };

  xdg.configFile."wezterm".source = ../../config/wezterm;
  xdg.configFile."nvim".source = ../../config/nvim;
}
