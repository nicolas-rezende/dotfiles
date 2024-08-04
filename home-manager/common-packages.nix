{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vim
    nixd
    nixfmt-rfc-style
    stow
    transcrypt
    lazygit
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
