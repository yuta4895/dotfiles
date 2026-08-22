{
  description = "Personal System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    herdr.url = "github:herdrdev/herdr/v0.8.2";
    herdr.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, herdr }: {
    # $ darwin-rebuild switch --flake .#YutaMBP
    darwinConfigurations."YutaMBP" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit self inputs; };
      modules = [
        ./hosts/darwin
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit self inputs; };
          home-manager.users.yuta = ./home/yuta/home.nix;
        }
      ];
    };
  };
}
