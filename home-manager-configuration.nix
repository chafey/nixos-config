{ config, pkgs, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "nixos-23.11";
  });
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
    nixvim.nixosModules.nixvim
  ];
 
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    #withNodeJs = true;
    extraConfigVim = pkgs.lib.fileContents ./init.vim;
    extraConfigLua = pkgs.lib.fileContents ./init.neovim.lua;
    globals.mapleader = " ";
    plugins.lsp = {
      enable = true;
      servers = {
        tsserver.enable = true;
        clangd.enable = true;
        cmake.enable = true;
      };
    };
    plugins.nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      sources = [
        {name = "nvim_lsp";}
	{name = "path";}
	{name = "buffer";}
      ];
    };
    plugins.telescope.enable = true;
    plugins.treesitter.enable = true;
  };

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
        ns = "sudo nixos-rebuild switch";
      };
      initExtra = pkgs.lib.fileContents ./init.zsh;
    };
    programs.git = {
      enable = true;
      userName  = "Chris Hafey";
      userEmail = "chafey@gmail.com";
    };
    programs.direnv = {
        enable = true;
        enableBashIntegration = true; # see note on other shells below
        nix-direnv.enable = true;
    };
    programs.dircolors.enable = true;
    programs.ripgrep.enable = true;
    programs.bash.enable = true;
    programs.htop.enable = true;
  };   
}
