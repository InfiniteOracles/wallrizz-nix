# WallRizz Nix Package

A Nix package for [WallRizz](https://github.com/5hubham5ingh/WallRizz) - a terminal-based wallpaper manager that displays wallpapers in a grid, allows users to select and set wallpapers while automatically customizing application color themes based on the chosen wallpaper.

## Features

- ✨ Terminal-based wallpaper grid interface
- 🎨 Automatic theme customization based on wallpaper colors
- 🌐 Browse and download wallpapers from GitHub repositories
- 🔧 Extensible theme system for various applications
- 🖼️ Multiple preview modes (grid, list)
- ⚡ Built with QuickJS for fast performance

## Installation

### Method 1: Direct Package Installation

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

### Method 2: Using the NixOS Module

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
        wallrizz.nixosModules.wallrizz
        {
          programs.wallrizz.enable = true;
        }
      ];
    };
  };
}
```

### Method 3: Using as Overlay

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
          nixpkgs.overlays = [ wallrizz.overlays.default ];
          environment.systemPackages = with pkgs; [
            wallrizz  # Now available as a regular package
          ];
        }
      ];
    };
  };
}
```

## Usage

### Basic Usage

```bash
# View wallpapers in current directory
wallrizz

# Specify wallpaper directory
wallrizz -d ~/Pictures/wallpapers

# Enable light theme
wallrizz -l

# Apply random wallpaper
wallrizz -r

# Browse online wallpapers
wallrizz -b
```

### Advanced Usage

```bash
# Download theme extensions
wallrizz -t -d ~/Pictures

# Set up periodic wallpaper changes (1 hour = 3600000ms)
wallrizz -v 3600000

# Custom grid size and image sizing
wallrizz -g 6x3 -s 40x12

# Browse from custom GitHub repositories
wallrizz -u "https://github.com/username/repo/tree/main/wallpapers"
```

### Configuration

WallRizz can be configured using command-line arguments or environment variables:

- `WALLPAPER_DIR`: Default wallpaper directory
- `WALLPAPER_REPO_URLS`: GitHub repository URLs for browsing
- `GITHUB_API_KEY`: GitHub API key for increased rate limits
- `WR_CB`: Callback function for interval modifications

## Development

### Using nix develop

```bash
git clone https://github.com/InfiniteOracles/wallrizz-nix.git
cd wallrizz-nix
nix develop
```

### Building locally

```bash
nix build
./result/bin/wallrizz --version
```

### Running directly

```bash
nix run github:InfiniteOracles/wallrizz-nix
```

## Supported Applications

WallRizz includes theme extensions for:

- 🦎 Hyprland
- 🐱 Kitty
- 🔥 Firefox
- 🦇 Btop
- 🔔 Dunst
- 🎨 Pywal
- 💻 VSCode

## Requirements

- Linux system with Nix/NixOS
- Terminal with image display support (for preview)
- ImageMagick (included in dependencies)

## License

This packaging is provided under the MIT License, same as the original WallRizz project.

## Contributing

Issues and pull requests are welcome! Please check the [original WallRizz repository](https://github.com/5hubham5ingh/WallRizz) for feature requests and bug reports related to the application itself.

## Links

- 🏠 [Original WallRizz Repository](https://github.com/5hubham5ingh/WallRizz)
- 📦 [This Nix Package](https://github.com/InfiniteOracles/wallrizz-nix)
- 🐧 [NixOS](https://nixos.org/)