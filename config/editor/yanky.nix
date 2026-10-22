let
  plug = mode: key: name: desc: {
    inherit mode key;
    action = "<Plug>(${name})";
    options = {
      inherit desc;
      remap = true;
    };
  };
in {
  plugins.yanky.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>p";
      # Opens through vim.ui.select, i.e. the Snacks picker
      action = "<cmd>YankyRingHistory<cr>";
      options.desc = "Yank History";
    }
    (plug ["n" "x"] "y" "YankyYank" "Yank Text")
    (plug "n" "p" "YankyPutAfter" "Put Text After Cursor")
    (plug ["n" "x"] "P" "YankyPutBefore" "Put Text Before Cursor")
    # Like builtin visual P: replace the selection without yanking it
    (plug "x" "p" "YankyPutBefore" "Paste without yanking selected text")
    (plug ["n" "x"] "gp" "YankyGPutAfter" "Put Text After Selection")
    (plug ["n" "x"] "gP" "YankyGPutBefore" "Put Text Before Selection")
    (plug "n" "[y" "YankyCycleForward" "Cycle Forward Through Yank History")
    (plug "n" "]y" "YankyCycleBackward" "Cycle Backward Through Yank History")
    (plug "n" "]p" "YankyPutIndentAfterLinewise" "Put Indented After Cursor (Linewise)")
    (plug "n" "[p" "YankyPutIndentBeforeLinewise" "Put Indented Before Cursor (Linewise)")
  ];
}
