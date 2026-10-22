{
  # Formatters are assigned per language in ./lang and installed by autoInstall
  plugins.conform-nvim = {
    enable = true;
    autoInstall.enable = true;

    settings = {
      notify_on_error = true;
      default_format_opts.lsp_format = "fallback";

      # A buffer-local vim.b.autoformat overrides the global vim.g.autoformat
      format_on_save.__raw = ''
        function(bufnr)
          local enabled = vim.b[bufnr].autoformat
          if enabled == nil then
            enabled = vim.g.autoformat
          end
          if enabled then
            return { timeout_ms = 3000 }
          end
        end
      '';
    };
  };

  keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>cf";
      action.__raw = "function() require('conform').format({ async = true }) end";
      options.desc = "Format";
    }
    {
      mode = ["n" "v"];
      key = "<leader>cF";
      action.__raw = "function() require('conform').format({ formatters = { 'injected' }, timeout_ms = 3000 }) end";
      options.desc = "Format Injected Langs";
    }
  ];

  extraConfigLua = ''
    Snacks.toggle({
      name = "Auto Format (Global)",
      get = function() return vim.g.autoformat end,
      set = function(state) vim.g.autoformat = state end,
    }):map("<leader>uf")

    Snacks.toggle({
      name = "Auto Format (Buffer)",
      get = function()
        if vim.b.autoformat == nil then
          return vim.g.autoformat
        end
        return vim.b.autoformat
      end,
      set = function(state) vim.b.autoformat = state end,
    }):map("<leader>uF")
  '';
}
