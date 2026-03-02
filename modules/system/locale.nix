{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Prague";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # XKB layout for Wayland/greetd
  services.xserver.xkb = {
    layout = "us,sk";
    variant = ",qwerty";
    options = "grp:alt_shift_toggle";
  };
}
