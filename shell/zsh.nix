{config, pkgs, lib, ... }: {
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        initExtraBeforeCompInit = ''
            eval "$(/opt/homebrew/bin/brew shellenv)"
	    eval "$(starship init zsh)"
	    export PATH=$PATH:/Users/kirb/Library/Python/3.9/bin:/Users/kirb/.local/bin:/Users/kirb/.spicetify
        '';
        shellAliases = {
                nupd = "cd ~/.config/nix-kirb && darwin-rebuild switch --flake .";
                g = "git";
                neofetch = "python3 -W ignore -m twidgets";
                skhd = "/nix/store/jrz05pcnlrzb0jwgalnvrmp0ja6xqb2q-skhd-0.3.9/bin/skhd";
                
        };
    };
}
