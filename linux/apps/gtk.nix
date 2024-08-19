{pkgs, ...}: {
  gtk = {
  enable = true;
  cursorTheme = {
    name = "catppuccin-mocha-green-cursors";
  };
  iconTheme = {
	name = "Papirus-Dark";
	  };

  theme = { name = "catppuccin-macchiato-green-compact+rimless,black";
    package = pkgs.catppuccin-gtk.override {
    accents = [ "green" ];
    size = "compact";
    variant = "macchiato";
    tweaks = [ "rimless" "black" ];
  };
  };
  };
}
