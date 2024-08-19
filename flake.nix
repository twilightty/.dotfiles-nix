{
  description = "Home Manager configuration of kirb";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # macOS Stuff
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-zsh-fzf-tab.url = "github:nixos/nixpkgs/8193e46376fdc6a13e8075ad263b4b5ca2592c03";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    # Share same stuff here

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, nix-darwin, nix-doom-emacs, ... } @ inputs:
    let
      nixpkgsConfig = {
	allowUnfree = true;
	allowUnsupportedSystem = false;
      };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."kirb" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit spicetify-nix;};
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ./spicetify.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };

      # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."emladevops" =
    let
        system = "aarch64-darwin";
	user = "kirb";
	hostname = "emladevops.local";
      in
      nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        inputs.nix-index-database.darwinModules.nix-index
        ./macos/darwin
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
          dock.autohide = true;
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
                ./macos/shell
                ./macos/shell/jankyborders.nix
		./macos/shell/nvim.nix
		./macos/shell/ohmytmux.nix
		./macos/shell/alacritty.nix
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
