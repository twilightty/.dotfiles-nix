{ config, pkgs, lib, inputs, system, ... }: {
    imports = [
        ./tmux.nix
    ];
    programs.neovim.enable = true;
}