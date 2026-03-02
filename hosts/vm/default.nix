{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/boot.nix
    ../../modules/system/locale.nix
    ../../modules/system/network.nix
    ../../modules/system/users.nix
    ../../modules/system/audio.nix
    ../../modules/system/tablet.nix
    ../../modules/system/logitech.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/greetd.nix
    ../../modules/desktop/fonts.nix
    ../../modules/system/virtualisation.nix
  ];

  home-manager.backupFileExtension = "bak";
  home-manager.users.marky = import ../../home;

  nixpkgs.config.allowUnfree = true;

  # nix-ld: allows running unpatched dynamic binaries (Unity Hub, Android SDK, etc.)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    openssl
    curl
    icu
    libz
  ];

  system.stateVersion = "25.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
