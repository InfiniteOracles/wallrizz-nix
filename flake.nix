{
  description = "WallRizz - A terminal-based wallpaper manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.callPackage ./default.nix { };
        
        packages.wallrizz = pkgs.callPackage ./default.nix { };
        
        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/wallrizz";
        };
        
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            quickjs
            imagemagick
          ];
        };
      }
    );
}