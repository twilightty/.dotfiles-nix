{ config, pkgs, lib, inputs, system, ... }: {
    imports = [
        ./tmux.nix
        ./emacs.nix
        ./zsh.nix
    ];
    programs.neovim.enable = true;
}