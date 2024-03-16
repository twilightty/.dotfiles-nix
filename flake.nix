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
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
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

          users.users.${user} = {
            home = "/Users/${user}";
            shell = pkgs.zsh;
          };

        programs.zsh.enable = true;
         services.nix-daemon.enable = true;

         security = {
          pam.enableSudoTouchIdAuth = true;
         };


        system.defaults = {
          dock.autohide = true;
          dock.mru-spaces = false;
          finder.AppleShowAllExtensions = true;
          finder.FXPreferredViewStyle = "clmv";
          loginwindow.LoginwindowText = "kirb:3";
          screencapture.location = "~/Screenshots";
          NSGlobalDomain.AppleInterfaceStyle = "Dark";
        };

          networking = {
            computerName = hostname;
            hostName = hostname;
            localHostName = hostname;
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
                ./shell/home.nix
              ];
              programs.neovim.enable = true;
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