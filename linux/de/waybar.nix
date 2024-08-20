{config, pkgs, lib, ...}: {

programs.waybar = {
  enable = true;
  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 35;
      output = ["DP-1"];
      modules-left = ["hyprland/workspaces" "hyprland/window"];
      modules-right = ["custom/spotify" "cpu" "memory" "pulseaudio" "network" "clock" "tray" ];
      "hyprland/workspaces" = {
        "on-click" = "activate";
		"format" = "{icon}";
		"format-icons" = {
			"1" = "I";
			"2" = "II";
			"3" = "III";
			"4" = "IV";
			"5" = "V";
			"6" = "VI";
			"7" = "VII";
			"8" = "VIII";
			"9" = "IX";
			"10" = "X";
		};
		"persistent-workspaces" = {
			"*" = 10;
		};
      };
      "tray" = {
        "spacing" = 10;
      };
	  "hyprland/window" = {
		"format" = "=> {}";
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

	  "custom/spotify" = {
	    format = "{}";
		exec = pkgs.writeShellScript "spotify" ''
python << END
#!/usr/bin/env python3
import gi
gi.require_version("Playerctl", "2.0")
from gi.repository import Playerctl, GLib
from gi.repository.Playerctl import Player
import argparse
import logging
import sys
import signal
import gi
import json
import os
from typing import List

logger = logging.getLogger(__name__)

def signal_handler(sig, frame):
    logger.info("Received signal to stop, exiting")
    sys.stdout.write("\n")
    sys.stdout.flush()
    # loop.quit()
    sys.exit(0)


class PlayerManager:
    def __init__(self, selected_player=None, excluded_player=[]):
        self.manager = Playerctl.PlayerManager()
        self.loop = GLib.MainLoop()
        self.manager.connect(
            "name-appeared", lambda *args: self.on_player_appeared(*args))
        self.manager.connect(
            "player-vanished", lambda *args: self.on_player_vanished(*args))

        signal.signal(signal.SIGINT, signal_handler)
        signal.signal(signal.SIGTERM, signal_handler)
        signal.signal(signal.SIGPIPE, signal.SIG_DFL)
        self.selected_player = selected_player
        self.excluded_player = excluded_player.split(',') if excluded_player else []

        self.init_players()

    def init_players(self):
        for player in self.manager.props.player_names:
            if player.name in self.excluded_player:
                continue
            if self.selected_player is not None and self.selected_player != player.name:
                logger.debug(f"{player.name} is not the filtered player, skipping it")
                continue
            self.init_player(player)

    def run(self):
        logger.info("Starting main loop")
        self.loop.run()

    def init_player(self, player):
        logger.info(f"Initialize new player: {player.name}")
        player = Playerctl.Player.new_from_name(player)
        player.connect("playback-status",
                       self.on_playback_status_changed, None)
        player.connect("metadata", self.on_metadata_changed, None)
        self.manager.manage_player(player)
        self.on_metadata_changed(player, player.props.metadata)

    def get_players(self) -> List[Player]:
        return self.manager.props.players

    def write_output(self, text, player):
        logger.debug(f"Writing output: {text}")

        output = {"text": text,
                  "class": "custom-" + player.props.player_name,
                  "alt": player.props.player_name}

        sys.stdout.write(json.dumps(output) + "\n")
        sys.stdout.flush()

    def clear_output(self):
        sys.stdout.write("\n")
        sys.stdout.flush()

    def on_playback_status_changed(self, player, status, _=None):
        logger.debug(f"Playback status changed for player {player.props.player_name}: {status}")
        self.on_metadata_changed(player, player.props.metadata)

    def get_first_playing_player(self):
        players = self.get_players()
        logger.debug(f"Getting first playing player from {len(players)} players")
        if len(players) > 0:
            # if any are playing, show the first one that is playing
            # reverse order, so that the most recently added ones are preferred
            for player in players[::-1]:
                if player.props.status == "Playing":
                    return player
            # if none are playing, show the first one
            return players[0]
        else:
            logger.debug("No players found")
            return None

    def show_most_important_player(self):
        logger.debug("Showing most important player")
        # show the currently playing player
        # or else show the first paused player
        # or else show nothing
        current_player = self.get_first_playing_player()
        if current_player is not None:
            self.on_metadata_changed(current_player, current_player.props.metadata)
        else:    
            self.clear_output()

    def on_metadata_changed(self, player, metadata, _=None):
        logger.debug(f"Metadata changed for player {player.props.player_name}")
        player_name = player.props.player_name
        artist = player.get_artist()
        title = player.get_title()
        title = title.replace("&", "&amp;")

        track_info = ""
        if player_name == "spotify" and "mpris:trackid" in metadata.keys() and ":ad:" in player.props.metadata["mpris:trackid"]:
            track_info = "Advertisement"
        elif artist is not None and title is not None:
            track_info = f"{artist} - {title}"
        else:
            track_info = title

        if track_info:
            if player.props.status == "Playing":
                track_info = " " + track_info
            else:
                track_info = " " + track_info
        # only print output if no other player is playing
        current_playing = self.get_first_playing_player()
        if current_playing is None or current_playing.props.player_name == player.props.player_name:
            self.write_output(track_info, player)
        else:
            logger.debug(f"Other player {current_playing.props.player_name} is playing, skipping")

    def on_player_appeared(self, _, player):
        logger.info(f"Player has appeared: {player.name}")
        if player.name in self.excluded_player:
            logger.debug(
                "New player appeared, but it's in exclude player list, skipping")
            return
        if player is not None and (self.selected_player is None or player.name == self.selected_player):
            self.init_player(player)
        else:
            logger.debug(
                "New player appeared, but it's not the selected player, skipping")

    def on_player_vanished(self, _, player):
        logger.info(f"Player {player.props.player_name} has vanished")
        self.show_most_important_player()

def parse_arguments():
    parser = argparse.ArgumentParser()

    # Increase verbosity with every occurrence of -v
    parser.add_argument("-v", "--verbose", action="count", default=0)

    parser.add_argument("-x", "--exclude", "- Comma-separated list of excluded player")

    # Define for which player we"re listening
    parser.add_argument("--player")

    parser.add_argument("--enable-logging", action="store_true")

    return parser.parse_args()


def main():
    arguments = parse_arguments()

    # Initialize logging
    if arguments.enable_logging:
        logfile = os.path.join(os.path.dirname(
            os.path.realpath(__file__)), "media-player.log")
        logging.basicConfig(filename=logfile, level=logging.DEBUG,
                            format="%(asctime)s %(name)s %(levelname)s:%(lineno)d %(message)s")

    # Logging is set by default to WARN and higher.
    # With every occurrence of -v it's lowered by one
    logger.setLevel(max((3 - arguments.verbose) * 10, 0))

    logger.info("Creating player manager")
    if arguments.player:
        logger.info(f"Filtering for player: {arguments.player}")
    if arguments.exclude:
        logger.info(f"Exclude player {arguments.exclude}")

    player = PlayerManager(arguments.player, arguments.exclude)
    player.run()


if __name__ == "__main__":
    main()
END
		'';
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

#window {
    padding: 0 10px;
}


'';
};
}
