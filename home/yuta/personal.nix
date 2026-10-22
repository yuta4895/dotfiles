# Personal Mac (YutaMBP, managed by nix-darwin).
{ pkgs, ... }: {
  imports = [ ./common.nix ];

  home.username = "yuta";
  home.homeDirectory = "/Users/yuta";

  home.packages = with pkgs; [
    opentofu
    awscli2

    nodejs_24
    pnpm
    deno

    uv
    python312

    gcc
    gnumake

    go

    ollama
  ];

  programs.git.settings.url."git@github.com:".insteadOf = "https://github.com/";
  programs.gh.settings.git_protocol = "ssh";

  programs.zsh = {
    shellAliases = {
      tf    = "tofu";
      tfi   = "tofu init";
      tfp   = "tofu plan";
      tfa   = "tofu apply";
      tfaa  = "tofu apply -auto-approve";
      tfd   = "tofu destroy";
      tfda  = "tofu destroy -auto-approve";
      tffmt = "tofu fmt -recursive";
      tfv   = "tofu validate";
      tfo   = "tofu output";
      tfs   = "tofu state";
      tfwl  = "tofu workspace list";
      tfws  = "tofu workspace select";
      tfwn  = "tofu workspace new";
    };
    initContent = ''
      complete -o nospace -C tofu tofu
    '';
  };
}
