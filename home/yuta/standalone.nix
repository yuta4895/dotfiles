# standalone home-manager, no nix-darwin.
#
# $ home-manager switch --flake .#standalone
{ ... }: {
  imports = [ ./common.nix ];

  home.username = "yuta.sakuma";
  home.homeDirectory = "/Users/yuta.sakuma";

  # Installs the `home-manager` CLI itself (nix-darwin provides it on YutaMBP).
  programs.home-manager.enable = true;

  programs.zsh = {
    shellAliases = {
      tf    = "terraform";
      tfi   = "terraform init";
      tfp   = "terraform plan";
      tfa   = "terraform apply";
      tfaa  = "terraform apply -auto-approve";
      tfd   = "terraform destroy";
      tfda  = "terraform destroy -auto-approve";
      tffmt = "terraform fmt -recursive";
      tfv   = "terraform validate";
      tfo   = "terraform output";
      tfs   = "terraform state";
      tfwl  = "terraform workspace list";
      tfws  = "terraform workspace select";
      tfwn  = "terraform workspace new";
    };
    initContent = ''
      autoload -U +X bashcompinit && bashcompinit
      complete -o nospace -C terraform terraform
    '';
  };

  # To override git settings, create ~/.gitconfig which is read after ~/.config/git.
  # Create ~/.gitconfig before switching, otherwise `git config --global` tries
  # to write to the read-only ~/.config/git/config.
}
