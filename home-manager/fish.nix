{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      reload = "source ~/.config/fish/config.fish";
      lpath = "echo $PATH | tr ':' '\n'";
      cat = "bat";
      ls = "eza --color=always --git --group-directories-first";
      la = "eza --color=always --git --group-directories-first --all";
      ll = "eza --color=always --git --group-directories-first --all --long";
      g = "git";
      gg = "lazygit";
      rm = "rm -rf";
      cp = "cp -r";
      c = "clear";
      d = "cd $NIX_CONFIG_DIR";
      rn = "sudo nixos-rebuild switch --flake $NIX_CONFIG_DIR";
    };
    functions = {
      md = ''
        function md
          mkdir -p $argv[1]
          cd $argv[1]
        end
      '';
      r = ''
        function r
          set dir_path (fd . -t d $CODE_DIR --max-depth 1 | fzf)

          if test -n "$dir_path"
            cd "$dir_path"
          end
        end
      '';
      nuke = ''
        function nuke
          git clean -d -X -f
          pnpm install
          pnpm nx run-many -t build
          pnpm install
        end
      '';
    };
  };

  # make bash open fish on startup, this ensures that a posix compliant shell (bash) is the login shell.
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
