{ config, pkgs, lib, ... }: {

    home.file.ohmytmux = {
        target = ".config/tmux/tmux.conf";
        text = builtins.readFile(builtins.fetchurl {
		url = "https://raw.githubusercontent.com/twilightty/.tmux/master/.tmux.conf";
		sha256 = "0pqminkkz2sbfzh401357svaadwf7i27cgdjrmwb4dpfyam7vnkx";
	});
    };
}
