{
  description = "An Express.js API using Nix Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "aarch64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    # Define the package
    packages.${system}.fullstack-app = pkgs.buildNpmPackage {
      pname = "fullstack-app";
      version = "1.0.0";
      src = self;
      nodejs = pkgs.nodejs;  # Defaults to latest Node.js in nixpkgs
    };

    # Define the development shell
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.nodejs
      ];

      shellHook = ''
        # Remove existing node_modules if any
        rm -rf node_modules

        # Create a symlink to node_modules from the Nix store
        ln -s ${self.packages.${system}.fullstack-app}/lib/node_modules node_modules
      '';
    };
  };
}
