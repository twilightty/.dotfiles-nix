{ config, pkgs, lib, ... }: {

    home.file.ohmytmux = {
        target = ".config/tmux/tmux.conf";
        text = builtins.readFile(builtins.fetchurl {
		url = "https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf";
		sha256 = "1x2vskq9jsppvgd8wp3h76034v7vp6rhc6kab3bwq4cjf13czp3j";
	});
    };
}
