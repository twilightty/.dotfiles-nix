{config, pkgs, lib, ... }: {
    programs.alacritty = {
        enable = true;
		settings = {
			
			env = {
				TERM = "xterm-256color";
			};

			window = {
				padding.x = 10;
				padding.y = 10;

				decorations = "Buttonless";

				opacity = 0.7;
				blur = true;

				option_as_alt = "Both";
			};
			font = {
				normal.family = "JetBrainsMono Nerd Font Mono";

				size = 13;
			};
		};
    };
}
