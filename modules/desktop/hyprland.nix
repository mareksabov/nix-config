{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
  };

  security.polkit.enable = true;

  # Ensure .desktop files, MIME data, and KDE menus are visible to Dolphin
  environment.pathsToLink = [
    "/share/applications"
    "/share/mime"
    "/share/icons"
    "/etc/xdg/menus"
    "/share/desktop-directories"
  ];

  environment.systemPackages = with pkgs; [
    hyprpolkitagent
    desktop-file-utils
    kdePackages.kservice
  ];
}
