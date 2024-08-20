{config, pkgs, lib, ...}: 
{
  services.hyprpaper = {
    enable = true;
    settings = {
	ipc = "on";
	splash =  false;
	preload = [ "/home/kirb/.config/home-manager/linux/de/wp.jpg" ];
	wallpaper = [
	  "DP-1, /home/kirb/.config/home-manager/linux/de/wp.jpg"	];
    };
  };
}
