{ pkgs, ... }:
{
  programs.git.delta.enable = true;
  programs.git.delta.package = pkgs.delta;

  programs.lazygit = {
    enable = true;
    settings = {
      # lazygit can pull the pager out of Git's config, but `programs.git.delta.enable = true` sets
      # the pager to `delta` directly, wheras `lazygit` requires `delta` to be called with
      # `--paging=never` due to rendering issues.
      #
      # https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Pagers.md
      git.paging.pager = "${pkgs.delta}/bin/delta --paging=never";

      update.method = "never"; # we will manage it here
      disableStartupPopups = true;
    };
  };
}
