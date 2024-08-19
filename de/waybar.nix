{config, pkgs, lib, ...}: {

programs.waybar = {
  enable = true;
  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 35;
      output = ["DP-1"];
      modules-left = ["hyprland/workspaces" ];
      modules-right = ["cpu" "memory" "pulseaudio" "network" "clock" "tray" ];
      "hyprland/workspaces" = {
        "on-click" = "activate";
      };
      "tray" = {
        "spacing" = 10;
      };
      "clock" = {
        "timezone" = "Asia/Ho_Chi_Minh";
	"format" = "{:%H:%M %Z} ";
	"format-alt" = "{:%a, %b %d %C%y} ";
	"tooltip" = false;

      };
      "network" = {
        "format-ethernet" = "{ifname}: {ipaddr}/{cidr}";
      };
      "pulseaudio" = {
	"format" = "{volume}% {icon} {format_source}";
	"format-bluetooth" =  "{volume}% {icon}  {format_source}";
	"format-bluetooth-muted" = " {icon}  {format_source}";
	"format-muted" = " {format_source}";
	"format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" ""];
        };
	"on-click-right" = "pavucontrol";
      };
      "memory" = {
   	"format" = "{}% ";
      };

      "cpu" = {
        "format" = "{usage}% ";
      };
    };
  };
  style = ''
@define-color bg-color rgb(68, 71, 90);               /* #3C413C */
@define-color bg-color-tray rgb (40, 42, 54);         /* #3C4144 */
@define-color bg-color-ws rgb (40, 42, 54);         /* #3C4144 */
@define-color bg-color-0 rgb (40, 42, 54);            /* #3C4144 */
@define-color bg-color-1 rgb(40, 42, 54);            /* #475f94 */
@define-color bg-color-2 rgb(40, 42, 54);           /* #107AB0 */
@define-color bg-color-3 rgb(40, 42, 54);            /* #017374 */
@define-color bg-color-4 rgb(40, 42, 54);             /* #1F3B4D */
@define-color bg-color-5 rgb(40, 42, 54);           /* #10A674 */
@define-color bg-color-6 rgb(40, 42, 54);           /* #4984B8 */
@define-color bg-color-7 rgb(40, 42, 54);               /* #000133 */
@define-color bg-color-8 rgb(40, 42, 54);            /* #08787F */
@define-color bg-color-9 rgb(40, 42, 54);             /* #214761 */
@define-color bg-color-10 rgb(40, 42, 54);           /* #6C3461 */
@define-color bg-color-11 rgb(40, 42, 54);             /* #005249 */
@define-color bg-color-12 rgb(40, 42, 54);          /* #31668A */
@define-color bg-color-13 rgb(40, 42, 54);           /* #6A6E09 */
@define-color bg-color-14 rgb(40, 42, 54);          /* #5B7C99 */
@define-color bg-color-15 rgb(40, 42, 54);            /* #1D2021 */
@define-color bg-color-16 rgb(40, 42, 54);            /* #29293D  */
@define-color fg-color rgb (248, 248, 242);           /* #f3f4f5 */
@define-color alert-bg-color rgb (255, 85, 85);       /* #bd2c40 */
@define-color alert-fg-color rgb (248, 248, 242);       /* #FFFFFF */
@define-color inactive-fg-color rgb(144, 153, 162);   /* #9099a2 */
@define-color inactive-bg-color rgb(68, 71, 90);      /* #404552 */


* {
  font-family: JetBrainsMono Nerd Font Mono;
  font-size: 14px;
  min-height: 0;
  opacity: 1.0;
  border: none;
  border-radius: 0;


}

window#waybar {
    background-color: rgba(40, 42, 54, 0.5);
    background-color: transparent;
    border-bottom: none;
    color: #f3f4f5;
    transition-property: background-color;
    transition-duration: .5s;
}

#workspaces button:hover {
    background: rgba(0, 0, 0, 0.2);
    box-shadow: inherit;
    border-bottom: 3px solid #f3f4f5;
}

#workspaces button.active {
    background-color: @bg-color;
    border-bottom: 3px solid #f3f4f5;
}

#workspaces button.urgent {
    background-color: @alert-bg-color;
}

#clock {
    padding: 0 10px;
    margin: 0 4px;
    background-color: #475f94;
}

#cpu {
    padding: 0 10px;
    margin: 0 4px;
    background-color: #6A6E09;
    color: #f3f4f5;
}

#memory {
    padding: 0 10px;
    margin: 0 4px;
    background-color: #10A674;
    color: #f3f4f5;
}

#pulseaudio {
    padding: 0 10px;
    margin: 0 4px;
    background-color: #31668A;
    color: #f3f4f5;
}

#pulseaudio {
    padding: 0 10px;
    margin: 0 4px;
    background-color: #214761;
    color: #f3f4f5;
}

#pulseaudio.muted {
    background-color: @inactive-bg-color;
    color: @inactive-fg-color;
}

#network {
    padding: 0 10px;
    margin: 0 4px;
    background-color: #4984B8;
    color: #f3f4f5;
}

#tray {
    padding: 0 10px;
    margin: 0 4px;
}

#network.disconnected {
    background-color: @alert-bg-color;
}


'';
};

}
