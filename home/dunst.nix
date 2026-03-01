{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 100;
        offset = "10x50";
        origin = "top-right";
        font = "JetBrainsMono Nerd Font 10";
        frame_color = "#8AADF4";
        separator_color = "frame";
        corner_radius = 5;
      };
      urgency_low = {
        background = "#1f1e24";
        foreground = "#cad3f5";
      };
      urgency_normal = {
        background = "#1f1e24";
        foreground = "#cad3f5";
      };
      urgency_critical = {
        background = "#1f1e24";
        foreground = "#ed8796";
        frame_color = "#ed8796";
      };
    };
  };
}
