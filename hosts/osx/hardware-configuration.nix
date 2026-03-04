# Placeholder — po inštalácii NixOS vo VM spusti:
#   nixos-generate-config --show-hardware-config > hosts/osx/hardware-configuration.nix
# a nahraď tento súbor výstupom.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # TODO: nahraď UUID podľa tvojich partícií
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/CHANGEME";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/CHANGEME";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
