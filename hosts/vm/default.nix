{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/boot.nix
    ../../modules/system/locale.nix
    ../../modules/system/network.nix
    ../../modules/system/users.nix
    ../../modules/system/audio.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/greetd.nix
    ../../modules/desktop/fonts.nix
  ];

  home-manager.users.marky = import ../../home;

  system.stateVersion = "25.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
