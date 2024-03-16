{ config, pkgs, lib, inputs, system, ... }: {
    imports = [
        ./yabai.nix
        ./homebrew.nix
        ./skhd.nix
    ];

}