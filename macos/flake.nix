{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-zsh-fzf-tab.url = "github:nixos/nixpkgs/8193e46376fdc6a13e8075ad263b4b5ca2592c03";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = { self, nix-darwin, nixpkgs, home-manager, nix-doom-emacs, ... }@inputs:
  let
    nixpkgsConfig = {
      allowUnfree = true;
      allowUnsupportedSystem = false;
    };
    user = "kirb";
    hostname = "emladevops.local";
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."emladevops" =
    let
        system = "aarch64-darwin";
      in
      nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        inputs.nix-index-database.darwinModules.nix-index
        ./darwin
        ({pkgs, inputs, ...}: {
          nixpkgs.config = nixpkgsConfig;
          system = {
            stateVersion = 4;
          };

          users.users.kirb = {
            home = "/Users/kirb";
            shell = pkgs.zsh;
          };

         services.nix-daemon.enable = true;
	       programs.zsh.enable = true;
         security = {
          pam.enableSudoTouchIdAuth = true;
         };


        system.defaults = {
          dock.autohide = false ;
          dock.mru-spaces = false;
          finder.AppleShowAllExtensions = true;
          finder.FXPreferredViewStyle = "clmv";
          NSGlobalDomain.AppleInterfaceStyle = "Dark";
        };

          nix = {
           useDaemon = true;
              package = pkgs.nixFlakes;
              gc = {
                automatic = true;
                user = user;
              };
              settings = {
                allowed-users = [ user ];
                experimental-features = [ "nix-command" "flakes" ];
                warn-dirty = false;
                auto-optimise-store = true;
              };
          };
        })

        home-manager.darwinModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs;
            };
            users.kirb = { ... }: with inputs; {
              imports = [
                ./shell
                ./shell/jankyborders.nix
		./shell/nvim.nix
		../shared/ohmytmux.nix
		./shell/alacritty.nix
                nix-doom-emacs.hmModule
              ];
              programs.neovim.enable = true;
              programs.doom-emacs = {
                enable = false;
              };
              home.stateVersion = "23.05";
            };
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."emladevops".pkgs;
  };
}
