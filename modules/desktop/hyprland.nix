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

  # Ensure .desktop files and MIME data are visible to Dolphin/KDE apps
  environment.pathsToLink = [ "/share/applications" "/share/mime" "/share/icons" ];

  environment.systemPackages = with pkgs; [
    hyprpolkitagent
    desktop-file-utils
  ];
}
