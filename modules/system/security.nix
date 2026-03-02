{ config, pkgs, ... }:

{
  # GNOME Keyring - stores passwords, SSH keys, GPG keys
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
    gnome-keyring
    seahorse  # GUI for managing keyring
    libsecret # Secret Service API library
  ];

  # D-Bus activation for secret service
  programs.seahorse.enable = true;
}
