{ config, pkgs, lib, ... }: {
    home.file.nvim= {
        target = ".config/nvim/init.lua";
				text = builtins.readFile ./nvim.lua;
    };
}
