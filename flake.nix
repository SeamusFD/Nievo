{
  description = "Nievo is a Nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , nixvim
    , flake-utils
    , ...
    }:
    let
      config = import ./config; # import the module directly
    in
    flake-utils.lib.eachDefaultSystem (system:
    let
      nixvimLib = nixvim.lib.${system};
      pkgs = import nixpkgs { inherit system; };
      nixvim' = nixvim.legacyPackages.${system};
      nvim = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        module = config;
        # You can use `extraSpecialArgs` to pass additional arguments to your module files
        extraSpecialArgs = {
          inherit self;
        };
      };
    in
    {
      checks = {
        # Run `nix flake check .` to verify that your config is not broken
        default = nixvimLib.check.mkTestDerivationFromNvim {
          inherit nvim;
          name = "Nievo";
        };
      };

      packages = {
        # Lets you run `nix run .` to start nixvim
        default = nvim;
      };

      formatter = pkgs.alejandra;
    });
}
