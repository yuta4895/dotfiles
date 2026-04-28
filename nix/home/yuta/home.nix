{ pkgs, self, ... }: {
  home.username = "yuta";
  home.homeDirectory = "/Users/yuta";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    git
    fd
    tree
  ];

  programs.bat = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      _fzf_compgen_path() {
        fd --hidden --follow --exclude ".git" . "$1"
      }
      _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
      }
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
 }
