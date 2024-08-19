{ config, pkgs, lib, ... }: {
    home.file.bordersrc = {
        executable = true;
        target = ".config/borders/bordersrc";
        text = ''
        #!/usr/bin/env sh
        borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=5.0
        '';
    };
}