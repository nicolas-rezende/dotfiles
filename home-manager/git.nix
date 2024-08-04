{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Nicolas Rezende";
    userEmail = "git@nicolasrezende.com";
    ignores = [
      ".DS_Store"
      "Thumbs.db"
      "*~"
      "*.swp"
      ".AppleDouble"
      ".LSOverride"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      ".vimrc.local"
      ".vim/coc-settings.json"
      "tscommand*.txt"
      "npm-debug.log"
      ".worktrees"
    ];
    extraConfig = {
      pull.rebase = true;
      credential.helper = "osxkeychain";
      init.defaultBranch = "main";
      rerere.enabled = "true";
      push.default = "current";
    };
    includes = [
      {
        condition = "hasconfig:remote.*.url:https://gitlab.sydle.com/**";
        contents = {
          user = {
            name = "Nicolas Gomes de Rezende";
            email = "nicolas.rezende@sydle.com";
          };
        };
      }
    ];
  };
}
