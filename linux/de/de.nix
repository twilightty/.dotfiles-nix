{ config, pkgs, lib, ... }: {
    imports = [
    	./hyprland.nix
	./waybar.nix
	./hyprpaper.nix
	./mako.nix
    ];
}
