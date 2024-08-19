{config, pkgs, lib, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
    	"$mod" = "ALT";
	"$shiftMod" = "ALT_SHIFT";

	bindm = [
	  "$mod, mouse:272, movewindow"
	  "$mod, mouse:273, resizewindow"
	];
	bind = [
 	  "$mod, RETURN, exec, alacritty"
	  "$mod, R, exec, wofi --show drun"
	  "$mod, H, movefocus, l"
	  "$mod, J, movefocus, d"
	  "$mod, K, movefocus, u"
	  "$mod, L, movefocus, r"
	  "$mod, J, togglesplit"
	  "$mod, P, pseudo"
	  "$mod, V, togglefloating"
	  "$mod, Q, killactive"
	  "$shiftMod, S , exec, hyprshot -m region"
	  "$shiftMod, F3, exec, hyprshot -m window"
	]
	++ (
	  builtins.concatLists (builtins.genList (
	    x: let
	      ws = let
	        c = (x + 1) / 10;
	      in
	        builtins.toString (x+1 - (c * 10));
	    in [
	      "$mod, ${ws}, workspace, ${toString(x+1)}"
	      "$mod SHIFT, ${ws}, movetoworkspace, ${toString(x+1)}"
	    ]
	   )
	   10));
    };
	extraConfig = ''
env = XCURSOR_THEME,catppuccin-mocha-green-cursors
env = XCURSOR_SIZE,24
env = HYPRSHOT_DIR,Screenshots
monitor=DP-1,highrr,0x0,1
gestures {
  workspace_swipe = true
  workspace_swipe_distance = 1300
}

exec-once = waybar

device {
  name = apple-inc.-magic-trackpad-2
  sensitivity = 0.5
  accel_profile = adaptive
}

input {
  touchpad {
  	natural_scroll = true
  	scroll_factor = 0.3
	tap-to-click = false
  }
}

animations {
    enabled = true

    # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

decoration {
    rounding = 10

    # Change transparency of focused and unfocused windows
    active_opacity = 1.0
    inactive_opacity = 1.0

    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)

    # https://wiki.hyprland.org/Configuring/Variables/#blur
    blur {
        enabled = true
        size = 3
        passes = 1
        
        vibrancy = 0.1696
    }
}

dwindle {
    pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true # You probably want this
}

# See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
master {
    new_status = master
}
	'';

  };
}
