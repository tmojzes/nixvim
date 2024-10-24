{
  plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    settings.update_in_insert = false;
    sources = {
      code_actions = {
        gitsigns.enable = true;
        statix.enable = true;
      };
      diagnostics = {
        statix.enable = true;
        yamllint.enable = true;
        staticcheck.enable = true;
      };
      formatting = {
        alejandra.enable = true;
        black = {
          enable = true;
          settings = ''
            {
              extra_args = { "--fast" },
            }
          '';
        };
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
          settings = ''
            {
              extra_args = { "--no-semi", "--single-quote" },
            }
          '';
        };
        stylua.enable = true;
        yamlfmt.enable = true;
        goimports.enable = true;
        gofumpt.enable = true;
        golines = {
          enable = true;
          settings = ''
            {
                extra_args = { "-m 110" },
            }
          '';
        };
      };
    };
  };
  keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>cf";
      action = "<cmd>lua vim.lsp.buf.format()<cr>";
      options = {
        silent = true;
        desc = "Format";
      };
    }
  ];
}
