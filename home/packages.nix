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
    kdePackages.kservice

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

    # Cloud sync
    nextcloud-client

    # Networking
    wget

    # Development - Languages & SDKs
    python3
    jdk17

    # Development - Tools
    vscode
    unityhub
    p7zip
    unzip
    zip
    blender
    android-tools
    git-lfs
    gh
    claude-code
    gemini-cli
  ];
}
