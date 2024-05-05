{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.chafey = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "18.09";
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
      oh-my-zsh = {
        enable = true;
        theme = "steeef";
      };
      shellAliases = {
        ls = "ls --color=auto";
        ns = "sudo nixos-rebuild switch";
      };
      initExtra = pkgs.lib.fileContents ./init.zsh;
    };
    programs.git = {
      enable = true;
      userName  = "Chris Hafey";
      userEmail = "chafey@gmail.com";
    };
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraConfig = pkgs.lib.fileContents ./init.vim;
    };
    programs = {
      direnv = {
        enable = true;
        enableBashIntegration = true; # see note on other shells below
        nix-direnv.enable = true;
      };
    };
    programs.dircolors.enable = true;
    programs.bash.enable = true;
    programs.htop.enable = true;
  };   
}
