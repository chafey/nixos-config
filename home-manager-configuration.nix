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
      oh-my-zsh = {
        enable = true;
        theme = "steeef";
      };
      initExtra = ''
nixify() {
  if [ ! -e ./.envrc ]; then
    echo "use nix" > .envrc
    direnv allow
  fi
  if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
    cat > default.nix <<'EOF'
with import <nixpkgs> {};
mkShell {
  packages = [
    pkgs.gnumake
    pkgs.cmake
    pkgs.clang
    pkgs.nodejs
  ];
}
EOF
  fi
}
'';
    };
    programs.git = {
      enable = true;
      userName  = "Chris Hafey";
      userEmail = "chafey@gmail.com";
    };
    programs.vim = {
      enable = true;
      settings = {};
      extraConfig = ''
        syntax on
        filetype on
        set tabstop=2 
        set shiftwidth=2
        set expandtab
        set smartindent
        set autoindent
        set smartcase
        set nu rnu
      ''; 
    };
    programs = {
      direnv = {
        enable = true;
        enableBashIntegration = true; # see note on other shells below
        nix-direnv.enable = true;
      };
    };
    programs.bash.enable = true;
  };   
}
