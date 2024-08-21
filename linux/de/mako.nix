{ config, lib, pkgs, ... }: {
	services.mako = {
		enable = true;
		layer = "top";
		anchor = "top-right";

	};
}
