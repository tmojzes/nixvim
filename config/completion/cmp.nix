{
  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      experimental.ghost_text = true;
      performance = {
        debounce = 60;
        fetching_timeout = 200;
        max_view_entries = 30;
      };
      snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
      formatting.fields = ["kind" "abbr" "menu"];
      sources = [
        {name = "nvim_lsp";}
        {name = "luasnip";}
        {name = "path";}
        {
          name = "buffer";
          keyword_length = 3;
        }
        {name = "emoji";}
      ];

      window = {
        completion.border = "solid";
        documentation.border = "solid";
      };

      mapping = {
        # Supertab: cycle items, then jump through snippets, then trigger completion
        "<Tab>" = ''
          cmp.mapping(function(fallback)
            local luasnip = require("luasnip")
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            local has_words_before = col ~= 0
              and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil

            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" })
        '';
        "<S-Tab>" = ''
          cmp.mapping(function(fallback)
            local luasnip = require("luasnip")
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" })
        '';
        "<C-j>" = "cmp.mapping.select_next_item()";
        "<C-k>" = "cmp.mapping.select_prev_item()";
        "<C-e>" = "cmp.mapping.abort()";
        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
      };
    };
  };
}
