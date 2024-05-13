{ config, pkgs, lib, ... }: {

    home.file.ohmytmux = {
        target = ".config/tmux/tmux.conf";
        text = builtins.readFile(builtins.fetchurl {
		url = "https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf";
		sha256 = "0z16p6d7vn58ia4pah8fza5sf6p6qkbxv1ssjdnpc3hib40vl6h0";
	});
    };
}
