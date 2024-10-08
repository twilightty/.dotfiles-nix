{config, pkgs, lib, ... }: {
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        initExtraBeforeCompInit = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
	    eval "$(starship init zsh)"
	    export PATH=$PATH:/Users/kirb/Library/Python/3.9/bin:/Users/kirb/.local/bin:/Users/kirb/.spicetify:/Users/kirb/.bun/bin
        '';
		oh-my-zsh = {
			enable = true;
			theme = "agnoster";
		};
        shellAliases = {
                nupd = "cd ~/.config/nix-kirb && darwin-rebuild switch --flake .";
                g = "git";
                skhd = "/nix/store/jrz05pcnlrzb0jwgalnvrmp0ja6xqb2q-skhd-0.3.9/bin/skhd";
 				ls = "eza --icons=always";               
				v = "nvim";
				nv = "nvim";
				mux = "tmuxinator start";
				muxs = "tmuxinator stop";
        };
    };
		programs.tmux = {
			enable = true;
			extraConfig = builtins.readFile ./tmux.conf;
			tmuxinator = {
				enable = true;
			};
		};
}
