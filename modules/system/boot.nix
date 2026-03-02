{ config, pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = false;
    grub = {
      enable = true;
      device = "nodev";      # EFI mode, nie MBR
      efiSupport = true;
      configurationLimit = 5;
      useOSProber = true;    # Detekuje Windows, Arch, atd.
    };
  };

  # Zram swap
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  # NTFS podpora (pre externé disky)
  boot.supportedFilesystems = [ "ntfs" ];

  # SSD TRIM
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };
}
