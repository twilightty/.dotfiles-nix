{ config, pkgs, lib, ... }: {
    services.skhd = {
        enable = true;
        skhdConfig = ''
            # block alt +a / u/ o/ s (jf)

            
        ''
    };
}