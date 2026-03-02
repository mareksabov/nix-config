{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Hyprland ecosystem
    hyprlock
    hypridle
    hyprpaper
    hyprpicker

    # Clipboard
    wl-clipboard
    wl-clip-persist
    cliphist

    # Screenshots
    grim
    slurp

    # File managers
    nnn
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.kio-extras
    kdePackages.qtwayland
    kdePackages.breeze-icons

    # Browser
    brave

    # Communication
    vesktop
    evolution

    # Media
    mpv
    vlc
    pavucontrol

    # Office
    libreoffice-fresh

    # Notifications
    libnotify

    # System tools
    btop
    fzf
    jq
    trash-cli
    wlogout

    # Editors
    neovim

    # XDG / file associations
    shared-mime-info
    xdg-utils

    # Networking
    wget
  ];
}
