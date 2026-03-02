{ config, pkgs, ... }:

{
  # Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # QEMU/libvirt
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
