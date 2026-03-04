{ config, pkgs, ... }:

{
  # NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.graphics.enable = true;

  # Ollama - enable CUDA acceleration
  services.ollama.package = pkgs.ollama-cuda.override {
    cudaArches = [ "sm_89" ];
  };
}
