{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellOptions = [ "histappend" ];
    initExtra = ''
      set -o vi

      # Atuin shell history
      if command -v atuin &> /dev/null; then
        eval "$(atuin init bash)"
      fi
    '';
    shellAliases = {
      vim = "nvim";
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      nnn = "nnn -c";
    };
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      NNN_OPENER = "~/.config/nnn/plugins/nuke";
      GUI = "1";
    };
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
  };
}
