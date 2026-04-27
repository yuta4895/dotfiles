{
  description = "Personal System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }: {
    # $ darwin-rebuild switch --flake .#YutaMBP
    darwinConfigurations."YutaMBP" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [
        ./nix/hosts/darwin
      ];
    };
  };
}
