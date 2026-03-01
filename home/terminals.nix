{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    ghostty
  ];

  xdg.configFile = {
    "kitty/kitty.conf".source = ../dotfiles/kitty/kitty.conf;
    "kitty/kitty.d/colors.conf".source = ../dotfiles/kitty/kitty.d/colors.conf;
    "ghostty/config".source = ../dotfiles/ghostty/config;
  };
}
