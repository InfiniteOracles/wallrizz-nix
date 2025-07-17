# WallRizz Nix Package

A Nix package for [WallRizz](https://github.com/5hubham5ingh/WallRizz) - a terminal-based wallpaper manager.

## Installation

### Using Nix Flakes (Add to your system flake)

Add to your system `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wallrizz.url = "github:InfiniteOracles/wallrizz-nix";
  };
  
  outputs = { self, nixpkgs, wallrizz, ... }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        {
          environment.systemPackages = with pkgs; [
            wallrizz.packages.${pkgs.system}.default
          ];
        }
      ];
    };
  };
}
```

### Alternative: As an overlay (if you prefer)

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wallrizz.url = "github:InfiniteOracles/wallrizz-nix";
  };
  
  outputs = { self, nixpkgs, wallrizz, ... }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        {
          nixpkgs.overlays = [
            (final: prev: {
              wallrizz = wallrizz.packages.${prev.system}.default;
            })
          ];
          environment.systemPackages = with pkgs; [
            wallrizz  # Now available as a regular package
          ];
        }
      ];
    };
  };
}
```

### Using nix-build

```bash
nix-build
./result/bin/wallrizz --help
```

### Using nix run

```bash
nix run github:YOUR_USERNAME/wallrizz-nix
```

## Usage

See the original [WallRizz documentation](https://github.com/5hubham5ingh/WallRizz) for usage instructions.

## License

This packaging is provided under the same license as the original WallRizz project (MIT).