{ config, pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./packages.nix
    ./hyprland.nix
    ./terminals.nix
    ./waybar.nix
    ./wofi.nix
    ./dunst.nix
    ./scripts.nix
  ];

  home.username = "marky";
  home.homeDirectory = "/home/marky";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
