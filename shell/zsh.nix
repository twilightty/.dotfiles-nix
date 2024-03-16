{config, pkgs, lib, ... }: {
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        initExtraBeforeCompInit = ''
            eval "$(/opt/homebrew/bin/brew shellenv)"
            eval "$(starship init zsh)"

            clear && python3 -W ignore -m twidgets
        '';
        shellAliases = {
                nupd = "cd ~/.config/nix-kirb && darwin-rebuild switch --flake .";
                g = "git";
                neofetch = "python3 -W ignore -m twidgets";
                
        };
    };
}