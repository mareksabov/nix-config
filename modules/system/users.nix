{ config, pkgs, ... }:

{
  users.users.marky = {
    isNormalUser = true;
    description = "Marek Sabov";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.bash;
  };

  security.sudo.wheelNeedsPassword = true;
}
