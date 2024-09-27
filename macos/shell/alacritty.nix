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

				opacity = 0.7;
				blur = true;

				decorations = "Full";

				option_as_alt = "Both";

				dynamic_title = false;
				title = "twilight<33";
				startup_mode = "Maximized";
			};
			font = {
				normal.family = "JetBrainsMono Nerd Font Mono";

				size = 13;
			};
		};
    };
}
