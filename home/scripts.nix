{ config, pkgs, ... }:

{
  home.file.".local/bin/cliphist-cleanup" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      cliphist wipe
    '';
  };

  # Systemd user service + timer: cliphist cleanup every 2 hours
  systemd.user.services.cliphist-cleanup = {
    Unit.Description = "Cliphist cleanup service";
    Service = {
      Type = "oneshot";
      ExecStart = "%h/.local/bin/cliphist-cleanup";
      Environment = [
        "WAYLAND_DISPLAY=wayland-1"
        "XDG_RUNTIME_DIR=/run/user/1000"
      ];
    };
  };

  systemd.user.timers.cliphist-cleanup = {
    Unit.Description = "Run cliphist cleanup every 2 hours";
    Timer = {
      OnBootSec = "10min";
      OnUnitActiveSec = "2h";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
