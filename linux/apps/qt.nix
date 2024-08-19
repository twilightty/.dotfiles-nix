{config, pkgs, lib, ...}: {
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "gtk2";
      package = pkgs.kdePackages.breeze;
    };
  };
}
