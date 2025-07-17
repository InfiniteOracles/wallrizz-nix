# WallRizz Nix Package

A Nix package for [WallRizz](https://github.com/5hubham5ingh/WallRizz) - a terminal-based wallpaper manager.

## Installation

### Using Nix Flakes

Add to your `flake.nix`:

```nix
{
  inputs = {
    # ... your other inputs
    wallrizz.url = "github:YOUR_USERNAME/wallrizz-nix";
  };
  
  outputs = { self, nixpkgs, wallrizz, ... }: {
    # In your system configuration
    nixosConfigurations.your-host = nixpkgs.lib.nixosSystem {
      # ... your config
      modules = [
        {
          environment.systemPackages = with pkgs; [
            wallrizz.packages.${system}.default
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