{ config, pkgs, ... }:

{
  users.users.marky = {
    isNormalUser = true;
    description = "Marek Sabov";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.bash;
  };

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  security.sudo.wheelNeedsPassword = true;
}
