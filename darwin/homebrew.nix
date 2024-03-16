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


            #browser
            "google-chrome"

            #prod
            "ableton-live-suite"
            "rekordbox"

            #font
            "font-jetbrains-mono-nerd-font"

            #i'm vietnamese :(
            "gotiengviet"

        ];

        taps = [
          "homebrew/bundle"
          "homebrew/cask-fonts"
          "homebrew/services"
          "FelixKratz/formulae"  
        ];
    };
}