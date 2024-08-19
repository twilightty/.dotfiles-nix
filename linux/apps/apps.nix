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

     opacity = 0.7;
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
      ll = "ls -lah";
      update = "home-manager switch";
      nupdate = "sudo nixos-rebuild switch";
    };
    oh-my-zsh = {
      enable = true;
      theme = "fino-time";
    };
  };


  imports = [
    ./git.nix
    ./gtk.nix 
    ./nvim.nix
	./qt.nix
  ];
}
