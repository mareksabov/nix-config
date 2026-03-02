{ config, pkgs, ... }:

{
  home.file.".local/bin/cliphist-cleanup" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      cliphist wipe
    '';
  };

  # Tablet follow focus - maps Wacom tablet to the currently focused monitor
  home.file.".local/bin/tablet-follow-focus" = {
    executable = true;
    text = ''
      #!/bin/bash
      # Automatically maps Wacom tablet to the currently focused monitor

      # Kill previous instances (not self or parent)
      for pid in $(pgrep -f "tablet-follow-focus"); do
          [ "$pid" != "$$" ] && [ "$pid" != "$PPID" ] && kill "$pid" 2>/dev/null
      done

      # Wait for OpenTabletDriver (up to 30s)
      for i in $(seq 1 60); do
          systemctl --user is-active opentabletdriver.service &>/dev/null && break
          sleep 0.5
      done
      systemctl --user is-active opentabletdriver.service &>/dev/null || { echo "OpenTabletDriver not running after 30s"; exit 1; }

      # Wait for OTD to detect the tablet (up to 30s)
      for i in $(seq 1 60); do
          hyprctl devices -j | jq -e '.tablets | length > 0' &>/dev/null && break
          sleep 0.5
      done
      hyprctl devices -j | jq -e '.tablets | length > 0' &>/dev/null || { echo "No tablet detected after 30s"; exit 1; }

      # Wait for Hyprland socket (up to 10s)
      for i in $(seq 1 20); do
          SOCK=$(find /run/user/1000/hypr -name ".socket2.sock" 2>/dev/null | head -1)
          [ -n "$SOCK" ] && break
          sleep 0.5
      done
      [ -z "$SOCK" ] && echo "Socket not found after 10s" && exit 1

      set_tablet_monitor() {
          hyprctl keyword input:tablet:output ""
          hyprctl keyword input:tablet:output "$1"
          echo "Tablet -> $1"
      }

      # Set initial monitor
      monitor=$(hyprctl activeworkspace -j | jq -r '.monitor')
      set_tablet_monitor "$monitor"

      # Listen for focus changes
      socat -U - UNIX-CONNECT:"$SOCK" | while read -r line; do
          case $line in
              focusedmon\>*)
                  monitor="''${line#*>>}"
                  monitor="''${monitor%%,*}"
                  set_tablet_monitor "$monitor"
                  ;;
          esac
      done
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
