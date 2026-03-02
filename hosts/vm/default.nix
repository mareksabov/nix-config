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
    ../../modules/system/vpn.nix
    ../../modules/system/security.nix
    ../../modules/system/services.nix
  ];

  home-manager.backupFileExtension = "bak";
  home-manager.users.marky = import ../../home;

  nixpkgs.config.allowUnfree = true;

  # nix-ld: allows running unpatched dynamic binaries (Unity Hub, Android SDK, etc.)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    zstd
    openssl
    curl
    icu
    libz
    libGL
    libGLU
    libuuid
    libX11
    libXext
    libXrender
    libXi
    libXrandr
    libXcursor
    libXdamage
    libXcomposite
    libXfixes
    libxcb
    libXxf86vm
    libXinerama
    alsa-lib
    fontconfig
    freetype
    glib
    gtk3
    nss
    nspr
    dbus
    expat
    libdrm
    mesa
    libxshmfence
    libxkbcommon
  ];

  system.stateVersion = "25.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
