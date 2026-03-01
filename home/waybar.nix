{ config, pkgs, ... }:

{
  home.packages = [ pkgs.waybar ];

  xdg.configFile = {
    "waybar/config".source = ../dotfiles/waybar/config;
    "waybar/style.css".source = ../dotfiles/waybar/style.css;
  };
}
