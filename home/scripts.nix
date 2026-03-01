{ config, pkgs, ... }:

{
  home.file.".local/bin/cliphist-cleanup" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      cliphist wipe
    '';
  };
}
