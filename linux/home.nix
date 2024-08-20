{ config, pkgs, spicetify-nix, ... }:
{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  nixpkgs.config.allowUnfree = true;

  home.username = "kirb";
  home.homeDirectory = "/home/kirb";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    discord
    vlc
    google-chrome
    catppuccin-cursors.mochaGreen
	libnotify
    xfce.thunar
    xfce.exo
    gvfs
    xfce.thunar-archive-plugin
    xfce.tumbler
    xfce.xfconf
    ranger
    wofi
    bluez
    blueman
    pavucontrol
    pfetch
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    rPackages.fontawesome
    cool-retro-term
    nerdfetch
    cava
    pipes
    hyprshot
	nodejs_22
	go
	virtualbox
	kdePackages.breeze-gtk
	kdePackages.breeze-icons
	kdePackages.breeze 
	catppuccin-papirus-folders
	papirus-folders
	lunar-client
	xdg-desktop-portal-hyprland
	playerctl
  ] ++
  [ (pkgs.nerdfonts.override {fonts = [ "FiraCode" "JetBrainsMono" ]; }) ];
  
  
  imports = [
    ./de/de.nix
    ./apps/apps.nix
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kirb/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


}
