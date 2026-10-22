let
  # The plugin's own terminal-mode maps rely on Vim's `<C-w>` termwinkey, which Neovim lacks,
  # so they type `:TmuxNavigate*` into the shell. Map with <cmd> in normal and terminal mode instead.
  nav = key: action: {
    mode = ["n" "t"];
    inherit key action;
  };
in {
  # <C-h/j/k/l> move between nvim splits (including terminals) and tmux panes
  plugins.tmux-navigator = {
    enable = true;
    settings.no_mappings = 1;
    keymaps = [
      (nav "<C-h>" "left")
      (nav "<C-j>" "down")
      (nav "<C-k>" "up")
      (nav "<C-l>" "right")
      (nav "<C-\\>" "previous")
    ];
  };

  plugins.oil.enable = true;
}
