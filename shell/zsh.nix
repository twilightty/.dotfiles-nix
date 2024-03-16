{config, pkgs, lib, ... }: {
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        initExtraBeforeCompInit = ''
            eval "$(/opt/homebrew/bin/brew shellenv)"
            eval "$(starship init zsh)"
        '';
        shellAliases = {
                nupd = "darwin-rebuild switch --flake .";
        };
    };
}