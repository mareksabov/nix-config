{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Marek Sabov";
    userEmail = "marek.sabov@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
    };
    lfs.enable = true;
  };

  programs.gh = {
    enable = true;
  };
}
