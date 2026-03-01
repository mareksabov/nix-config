{ config, pkgs, ... }:

{
  xdg.configFile = {
    "hypr/hyprland.conf".source = ../dotfiles/hypr/hyprland.conf;
    "hypr/hyprlock.conf".source = ../dotfiles/hypr/hyprlock.conf;
    "hypr/hypridle.conf".source = ../dotfiles/hypr/hypridle.conf;
    "hypr/hyprpaper.conf".source = ../dotfiles/hypr/hyprpaper.conf;
  };
}
