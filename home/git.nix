{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Marek Sabov";
      user.email = "marek.sabov@gmail.com";
      init.defaultBranch = "main";
      credential.helper = "store";
    };
    lfs.enable = true;
  };

  programs.gh = {
    enable = true;
  };
}
