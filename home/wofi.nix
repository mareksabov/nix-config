{ config, pkgs, ... }:

{
  home.packages = [ pkgs.wofi ];

  xdg.configFile = {
    "wofi/config".source = ../dotfiles/wofi/config;
    "wofi/style.css".source = ../dotfiles/wofi/style.css;
  };
}
