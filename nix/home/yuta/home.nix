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
}
