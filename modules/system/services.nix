{ config, pkgs, ... }:

{
  # Printing
  services.printing.enable = true;

  # GVFS - Trash, MTP, SMB support for Dolphin
  services.gvfs.enable = true;

  # Ollama - local AI
  services.ollama.enable = true;
  services.ollama.host = "0.0.0.0";

  # TeamViewer
  services.teamviewer.enable = true;

  environment.systemPackages = with pkgs; [
    gvfs
  ];
}
