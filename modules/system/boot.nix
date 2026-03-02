{ config, pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      default = 0;
      timeoutStyle = "menu";
      gfxmodeEfi = "auto";
      gfxpayloadEfi = "keep";
    };
  };

  # Zram swap
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  # SSD TRIM
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };
}
