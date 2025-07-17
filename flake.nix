{
  description = "WallRizz - A terminal-based wallpaper manager with theme customization";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        wallrizz = pkgs.callPackage ./default.nix { };
      in
      {
        packages = {
          default = wallrizz;
          wallrizz = wallrizz;
        };
        
        apps.default = {
          type = "app";
          program = "${wallrizz}/bin/wallrizz";
          meta = {
            description = "Run WallRizz wallpaper manager";
            mainProgram = "wallrizz";
          };
        };
        
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            quickjs
            imagemagick
          ];
          
          shellHook = ''
            echo "WallRizz development environment"
            echo "Build with: nix build"
            echo "Run with: nix run"
          '';
        };
        
      }
    ) // {
      # For use as overlay
      overlays.default = final: prev: {
        wallrizz = self.packages.${final.system}.default;
      };
      
      # Additional outputs for NixOS modules
      nixosModules.wallrizz = { config, lib, pkgs, ... }: {
        options.programs.wallrizz = {
          enable = lib.mkEnableOption "WallRizz wallpaper manager";
          package = lib.mkOption {
            type = lib.types.package;
            default = self.packages.${pkgs.system}.default;
            description = "The WallRizz package to use";
          };
        };
        
        config = lib.mkIf config.programs.wallrizz.enable {
          environment.systemPackages = [ config.programs.wallrizz.package ];
        };
      };
    };
}