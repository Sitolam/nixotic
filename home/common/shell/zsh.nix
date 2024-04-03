{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        save = 10000;
        size = 10000;
        path = "$HOME/.cache/zsh_history";
      };

      initExtra = ''
        bindkey '^[[1;5C' forward-word # Ctrl+RightArrow
        bindkey '^[[1;5D' backward-word # Ctrl+LeftArrow

        zstyle ':completion:*' completer _complete _match _approximate
        zstyle ':completion:*:match:*' original only
        zstyle ':completion:*:approximate:*' max-errors 1 numeric
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

        # HACK! Simple shell function to patch ruff bins downloaded by tox from PyPI to use
        # the ruff included in NixOS - needs to be run each time the tox enviroment is
        # recreated
        patch_tox_ruff() {
          for x in $(find .tox -name ruff -type f -print); do
            rm $x;
            ln -sf $(which ruff) $x; 
          done
        }

        clean-crafts-lxc() {
          for CRAFT in snapcraft rockcraft charmcraft; do 
            lxc --project $CRAFT list -fcsv -cn | xargs lxc --project $CRAFT delete -f >/dev/null
          done
        }
        
        export EDITOR=vim
      '';

      shellAliases = {
        ls = "eza -gl --git --color=automatic";
        tree = "eza --tree";
        cat = "bat";

        ip = "ip --color";
        ipb = "ip --color --brief";

        gac = "git add -A  && git commit -a";
        gp = "git push";
        gst = "git status -sb";

        htop = "btm -b";
        neofetch = "fastfetch";

        open = "xdg-open";

        opget = "op item get \"$(op item list --format=json | jq -r '.[].title' | fzf)\"";

        speedtest = "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";

        cleanup-nix = "sudo nix-collect-garbage -d";
        rln = "sudo nixos-rebuild switch --flake /home/jon/nixos-config";
        rlh = "home-manager switch --flake /home/jon/nixos-config";
        rlb = "rln;rlh";
      };
    };
  };
}
