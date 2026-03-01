{ config, pkgs, ... }:

{
  home.packages = [ pkgs.wofi ];

  xdg.configFile = {
    "wofi/config".source = ../dotfiles/wofi/config;
  };
}
