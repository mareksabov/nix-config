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

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
  };

  # GTK theming
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Qt theming - use qt6ct with Fusion style
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "fusion";
  };

  # KDE/Dolphin: set Kitty as terminal for "Open Terminal Here"
  xdg.configFile."kdeglobals".text = ''
    [General]
    TerminalApplication=kitty
    TerminalService=kitty.desktop
  '';

  # Brave + VS Code: force X11 backend (Wayland fix)
  xdg.configFile."brave-flags.conf".text = "--ozone-platform=x11\n";
  xdg.configFile."code-flags.conf".text = "--ozone-platform=x11\n";

  # Default terminal for XDG
  xdg.configFile."xdg-terminals.list".text = "kitty\n";

  # nnn file opener plugin
  xdg.configFile."nnn/plugins/nuke" = {
    source = ../dotfiles/nnn/plugins/nuke;
    executable = true;
  };

  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  programs.home-manager.enable = true;
}
