{ config, pkgs, lib, inputs, system, ... }: {
    imports = [
        ./tmux.nix
        ./emacs.nix
    ];
    programs.neovim.enable = true;
}