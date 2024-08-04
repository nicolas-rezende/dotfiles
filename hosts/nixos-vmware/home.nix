{ config, pkgs, lib, ... }:

{
  imports = [
    ../../home-manager/common-packages.nix
    ../../home-manager/common-variables.nix
    ../../home-manager/fish.nix
    ../../home-manager/git.nix
  ];

  home.username = "nicolas";
  home.homeDirectory = "/home/nicolas";

  xdg.enable = true;

  home.file = {
    "/home/nicolas/.npmrc".source = ../../dotfiles/npm/.npmrc;
    "/home/nicolas/.local/share/code-server/User/settings.json".source = ../../dotfiles/vscode/settings.json;
    "/home/nicolas/.vscode-extensions.json".source = ../../dotfiles/vscode/extensions.json;
  };

  home.packages = with pkgs; [
    # Sync Visual Studio Code Extensions script, this line imports the scripts and adds it to the PATH
    (writeShellScriptBin "se" (builtins.readFile ./scripts/sync-code-server-extensions.sh))
  ];

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
