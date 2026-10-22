{
  description = "A LazyVim-inspired Nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        nixvimConfig = nixvim.lib.evalNixvim {
          inherit system;
          modules = [./config];
          extraSpecialArgs = {inherit inputs;};
        };
        nvim = nixvimConfig.config.build.package;
      in {
        # `nix run .` starts nixvim
        packages.default = nvim;

        checks = {
          # Builds the config and launches it, failing on startup errors or warnings
          default = nixvimConfig.config.build.test;

          format = pkgs.runCommand "check-format" {nativeBuildInputs = [pkgs.alejandra];} ''
            alejandra --check ${./.}
            touch $out
          '';
        };

        # `nix fmt` passes no arguments, so default to the whole repo
        formatter = pkgs.writeShellScriptBin "alejandra" ''
          exec ${pkgs.lib.getExe pkgs.alejandra} "''${@:-.}"
        '';

        devShells.default = pkgs.mkShell {
          packages = [
            nvim
            pkgs.alejandra
            pkgs.nixd
            pkgs.statix
            pkgs.deadnix
          ];
        };
      };
    };
}
