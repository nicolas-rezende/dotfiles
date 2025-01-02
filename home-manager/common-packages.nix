{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vim
    nixd
    nixfmt-rfc-style
    transcrypt
    eza
    bat
    fzf
    fd
    openssl
    nodejs
    pnpm
    jq
  ];
}
