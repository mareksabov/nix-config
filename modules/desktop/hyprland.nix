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

  # KDE/Dolphin needs applications.menu for "Open With" to list apps
  environment.etc."xdg/menus/applications.menu".text = ''
    <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
     "http://www.freedesktop.org/standards/menu-spec/menu-1.0.dtd">
    <Menu>
      <Name>Applications</Name>
      <DefaultAppDirs/>
      <DefaultDirectoryDirs/>
      <DefaultMergeDirs/>
      <Menu>
        <Name>Accessories</Name>
        <Include>
          <And><Category>Utility</Category><Not><Category>System</Category></Not></And>
        </Include>
      </Menu>
      <Menu>
        <Name>Education</Name>
        <Include><Category>Education</Category></Include>
      </Menu>
      <Menu>
        <Name>Graphics</Name>
        <Include><Category>Graphics</Category></Include>
      </Menu>
      <Menu>
        <Name>Internet</Name>
        <Include><Category>Network</Category></Include>
      </Menu>
      <Menu>
        <Name>Sound &amp; Video</Name>
        <Include>
          <Category>AudioVideo</Category>
          <Category>Audio</Category>
          <Category>Video</Category>
        </Include>
      </Menu>
      <Menu>
        <Name>Office</Name>
        <Include><Category>Office</Category></Include>
      </Menu>
      <Menu>
        <Name>Development</Name>
        <Include><Category>Development</Category></Include>
      </Menu>
      <Menu>
        <Name>Settings</Name>
        <Include><Category>Settings</Category></Include>
      </Menu>
      <Menu>
        <Name>System Tools</Name>
        <Include>
          <And><Category>System</Category><Not><Category>Settings</Category></Not></And>
        </Include>
      </Menu>
    </Menu>
  '';
}
