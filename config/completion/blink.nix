{
  # Mirrors LazyVim's default completion (blink.cmp); snippets use vim.snippet + friendly-snippets
  plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        appearance.nerd_font_variant = "mono";
        completion = {
          accept.auto_brackets.enabled = true;
          menu.draw.treesitter = ["lsp"];
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
          };
        };
        sources = {
          default = ["lsp" "path" "snippets" "buffer" "emoji"];
          # Type `:` followed by a name to insert an emoji
          providers.emoji = {
            module = "blink-emoji";
            name = "Emoji";
            score_offset = 15;
          };
        };
        cmdline.enabled = false;
        # <CR> accepts, <C-n>/<C-p> select, <Tab>/<S-Tab> jump through snippet placeholders
        keymap = {
          preset = "enter";
          "<C-y>" = ["select_and_accept"];
        };
      };
    };

    blink-emoji.enable = true;
    friendly-snippets.enable = true;
  };
}
