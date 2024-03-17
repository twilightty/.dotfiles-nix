{config, pkgs, lib, ...}: {
    homebrew = {
        enable = true;
        global = {
            autoUpdate = false;

        };
        
        brews = [
            "git"
            "starship"
            "borders"
            "fswatch"
            "docker"
            "ripgrep"
        ];

        casks = [
            "iterm2" #shell
            "aldente" #battery stuff
            "macfuse" # fs utils
            "karabiner-elements" #vimmy movement
            "hiddenbar" # j4f
            "obs" # why not?
            "keycastr" #fr
            "the-unarchiver"
            "wireshark"
            "sf-symbols"
            "eul"

            #irc 
            "zoom"
            "slack"
            "discord"
            "notion"
            "telegram"


            #browser
            "google-chrome"

            #prod
            "ableton-live-suite"
            "rekordbox"
            "native-access"

            #font
            "font-jetbrains-mono-nerd-font"

            #i'm vietnamese :(
            "gotiengviet"

            "webstorm"
            "intellij-idea"
            "goland"
            "arturia-software-center"

            "plex"
            "sublime-merge"
            "microsoft-remote-desktop"

            #office stuff

            "libreoffice"
            "microsoft-office-businesspro"

            "cloudflare-warp"

            "vmware-fusion"

            "lunar"

        ];

        taps = [
          "homebrew/bundle"
          "homebrew/cask-fonts"
          "homebrew/services"
          "FelixKratz/formulae"  
        ];
    };
}