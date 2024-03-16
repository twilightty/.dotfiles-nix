{ config, pkgs, lib, ... }: {
    services.yabai = {
        enable = true;
        enableScriptingAddition = true;
        config = {
                  external_bar = "all:0:0";
      layout = "bsp";
      auto_balance = "on";

      mouse_modifier = "alt";
      # set modifier + right-click drag to resize window (default: resize)
      mouse_action2 = "resize";
      # set modifier + left-click drag to resize window (default: move)
      mouse_action1 = "move";

      mouse_follows_focus = "off";
      focus_follows_mouse = "autofocus";

      # gaps
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 15;
        };

    extraConfig = ''

        # rules

        yabai -m rule --add app="^System Settings$"    manage=off
        yabai -m rule --add app="^System Information$" manage=off
        yabai -m rule --add app="^System Preferences$" manage=off
        yabai -m rule --add title="Preferences$"       manage=off
        yabai -m rule --add title="Settings$"          manage=off
    
        # wp management
        yabai -m space 1 --label todo
        yabai -m space 2 --label productive
        yabai -m space 3 --label irc
        yabai -m space 10 --label utils

        yabai -m rule --add app="Music" space=utils

        borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=5.0 &

    '';
    };

}