{ config, pkgs, lib, inputs, system, ... }: {
    imports = [
        ./emacs.nix
        ./zsh.nix
    ];
    programs.neovim.enable = true;
    programs.jq.enable = true;
    programs.gh.enable = true;
}
