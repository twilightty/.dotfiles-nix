{config, pkgs, lib, ... }: {
    programs.alacritty = {
    enable = true;
		settings = {
			
		env = {
			TERM = "xterm-256color";
		};

		window = {
			padding.x = 15;
			padding.y = 15;

			opacity = 0.7;
			blur = true;

			decorations = "Buttonless";

			option_as_alt = "Both";

			dynamic_title = false;
			title = "twilight<33";
		};
		font = {
		normal.family = "JetBrainsMono Nerd Font Mono";

		size = 13;
		};
	};
 };
}
