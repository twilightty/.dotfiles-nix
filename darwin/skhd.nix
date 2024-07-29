{ config, pkgs, lib, ... }: {
    services.skhd = {
        enable = true;
        skhdConfig = ''
            # block alt +a / u/ o/ s (jf)
            
            shift + alt - 1: yabai -m window --space  1; yabai -m space --focus 1
            shift + alt - 2: yabai -m window --space  2; yabai -m space --focus 2
            shift + alt - 3: yabai -m window --space  3; yabai -m space --focus 3
            shift + alt - 4: yabai -m window --space  4; yabai -m space --focus 4
            shift + alt - 5: yabai -m window --space  5; yabai -m space --focus 5
            shift + alt - 6: yabai -m window --space  6; yabai -m space --focus 6
            shift + alt - 7: yabai -m window --space  7; yabai -m space --focus 7
            shift + alt - 8: yabai -m window --space  8; yabai -m space --focus 8
            shift + alt - 9: yabai -m window --space  9; yabai -m space --focus 9
            shift + alt - 0: yabai -m window --space  10; yabai -m space --focus 10

            # Float / Unfloat window
            shift + alt - space : \
            yabai -m window --toggle float; \
            yabai -m window --toggle border

            alt - d : yabai -m space --layout $(yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "stack" else "bsp" end')
        '';
        
    };
}
