{ config, pkgs, ... }:

{
  # OpenVPN
  services.openvpn.servers = {};  # placeholder - configure specific servers as needed

  # WireGuard tools
  networking.firewall.checkReversePath = "loose";  # needed for WireGuard

  environment.systemPackages = with pkgs; [
    # ProtonVPN
    protonvpn-gui
    protonvpn-cli_2

    # OpenVPN + NetworkManager integration
    openvpn
    networkmanager-openvpn

    # WireGuard
    wireguard-tools
  ];

  # NetworkManager plugins for VPN protocols
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];
}
