{config, pkgs, lib, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
  env = {
     TERM = "xterm-256color";
  };

  window = {
     padding.x = 10;
     padding.y = 10;

     opacity = 1;
     blur = true;
  };
  shell = {
    program = "zsh";
  };

  font = {
    normal = {
      family = "JetBrainsMono Nerd Font Mono";
      style = "Regular";
    };
  };
};
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
	  ls = "lsd -h";
	  l = "lsd -h";
      ll = "lsd -lah";
      update = "home-manager switch";
	  g = "git";
	  bunnyfetch = "bunnyfetch 2> /dev/null";
	  neofetch = "bunnyfetch 2> /dev/null";
	  nfetch = "bunnyfetch 2> /dev/null";
	  nf = "bunnyfetch 2> /dev/null";
    };
    oh-my-zsh = {
      enable = true;
      theme = "fino-time";
    };
  };


  imports = [
    ./git.nix
    ./gtk.nix 
    ../../shared/nvim.nix
	../../shared/ohmytmux.nix
	./qt.nix
  ];
}
