{
  description = "An Express.js API using Nix Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    # Define the system architecture
    system = "x86_64-linux";  # Adjust as needed
    pkgs = import nixpkgs { inherit system; };
  in
  {
    # Define the package
    packages.${system}.fullstack-app = pkgs.buildNpmPackage {
      pname = "fullstack-app";
      version = "1.0.0";
      src = self;
      # Optionally, you can specify nodejs version
      nodejs = pkgs.nodejs;  # Defaults to latest Node.js in nixpkgs
    };

    # Define the development shell
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.nodejs
      ];
    };
  }
}
