{config, pkgs, lib, ... }: {
    programs.zsh = {
        enable = true;
        initExtraBeforeCompInit = ''
            eval "$(/opt/homebrew/bin/brew shellenv)"
            eval "$(starship init zsh)"
        '';
    };
}