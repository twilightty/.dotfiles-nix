{ config, pkgs, lib, ... }: {

    home.file.ohmytmux = {
        target = ".config/tmux.conf";
        text = builtins.readFile(builtins.fetchurl {
		url = "https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf";
		sha256 = "0735lnjz637sw4lajdykxqcrldfm8bbajvk2rdkig95hchlpikiv";
	});
    };
}
