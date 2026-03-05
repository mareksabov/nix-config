{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellOptions = [ "histappend" ];
    initExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
      PS1='[\u@\h \W]\$ '
      set -o vi

      # Dynamically update PS1 and tab title based on nix shell
      # Must be in PROMPT_COMMAND because nix develop sets IN_NIX_SHELL after .bashrc
      __nix_ps1() {
        if [ -n "$IN_NIX_SHELL" ]; then
          PS1='\[\e]2;[nix] \u@\h \w\a\][\[\e[36m\]nix\[\e[0m\]:\u@\h \W]\$ '
        else
          PS1='\[\e]2;\u@\h \w\a\][\u@\h \W]\$ '
        fi
      }
      PROMPT_COMMAND="__nix_ps1;''${PROMPT_COMMAND}"

      export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"
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
      GUI = "1";
    };
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
