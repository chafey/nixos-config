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
