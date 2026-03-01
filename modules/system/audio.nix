{ config, pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Disable PulseAudio (conflicts with PipeWire)
  hardware.pulseaudio.enable = false;

  # RealtimeKit for PipeWire priority
  security.rtkit.enable = true;
}
