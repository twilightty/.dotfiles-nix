{ config, pkgs, lib, inputs, system, ... }: {
    imports = [
        ./zsh.nix
    ];
    programs.neovim.enable = true;
    programs.jq.enable = true;
    programs.gh.enable = true;
}
