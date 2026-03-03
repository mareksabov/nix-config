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
      useOSProber = false;
      extraEntries = ''
        menuentry "Arch Linux" --class arch --class gnu-linux --class gnu --class os {
          insmod part_gpt
          insmod ext2
          search --no-floppy --fs-uuid --set=root 38591bbf-faf7-458b-a051-1452c2b16d4f
          linux /boot/vmlinuz-linux root=UUID=38591bbf-faf7-458b-a051-1452c2b16d4f rw zswap.enabled=0 rootfstype=ext4 loglevel=3 quiet nvidia_drm.modeset=1
          initrd /boot/intel-ucode.img /boot/initramfs-linux.img
        }
        menuentry "Windows 11" --class windows --class os {
          insmod part_gpt
          insmod fat
          insmod chain
          search --no-floppy --fs-uuid --set=root FA76-268E
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
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
