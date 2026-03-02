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

    # Media
    mpv
    pavucontrol

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

    # Networking
    wget
  ];
}
