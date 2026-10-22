let
  map = key: action: desc: {
    mode = "n";
    inherit key action;
    options.desc = desc;
  };
in {
  plugins.bufferline = {
    enable = true;
    settings.options = {
      always_show_bufferline = false;
      diagnostics = "nvim_lsp";
      numbers = "none";
      close_command.__raw = "function(n) Snacks.bufdelete(n) end";
      right_mouse_command.__raw = "function(n) Snacks.bufdelete(n) end";
      diagnostics_indicator.__raw = ''
        function(_, _, diag)
          local ret = (diag.error and " " .. diag.error .. " " or "")
            .. (diag.warning and " " .. diag.warning or "")
          return vim.trim(ret)
        end
      '';
      offsets = [
        {filetype = "snacks_layout_box";}
      ];
    };
  };

  keymaps = [
    (map "<S-h>" "<cmd>BufferLineCyclePrev<cr>" "Prev Buffer")
    (map "<S-l>" "<cmd>BufferLineCycleNext<cr>" "Next Buffer")
    (map "[b" "<cmd>BufferLineCyclePrev<cr>" "Prev Buffer")
    (map "]b" "<cmd>BufferLineCycleNext<cr>" "Next Buffer")
    (map "[B" "<cmd>BufferLineMovePrev<cr>" "Move Buffer Prev")
    (map "]B" "<cmd>BufferLineMoveNext<cr>" "Move Buffer Next")
    (map "<leader>bb" "<cmd>e #<cr>" "Switch to Other Buffer")
    (map "<leader>`" "<cmd>e #<cr>" "Switch to Other Buffer")
    (map "<leader>bd" {__raw = "function() Snacks.bufdelete() end";} "Delete Buffer")
    (map "<leader>bo" {__raw = "function() Snacks.bufdelete.other() end";} "Delete Other Buffers")
    (map "<leader>bD" "<cmd>bd<cr>" "Delete Buffer and Window")
    (map "<leader>bl" "<cmd>BufferLineCloseLeft<cr>" "Delete Buffers to the Left")
    (map "<leader>br" "<cmd>BufferLineCloseRight<cr>" "Delete Buffers to the Right")
    (map "<leader>bp" "<cmd>BufferLineTogglePin<cr>" "Toggle Pin")
    (map "<leader>bP" "<cmd>BufferLineGroupClose ungrouped<cr>" "Delete Non-Pinned Buffers")
  ];
}
