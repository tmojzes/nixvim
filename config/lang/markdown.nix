# Port of LazyVim's lang.markdown extra
{
  lsp.servers.marksman.enable = true;

  plugins = {
    lint.lintersByFt.markdown = ["markdownlint-cli2"];

    conform-nvim.settings = {
      formatters_by_ft = {
        markdown = ["markdownlint-cli2" "markdown-toc"];
        "markdown.mdx" = ["markdownlint-cli2" "markdown-toc"];
      };
      formatters = {
        # Only regenerate a table of contents where one is requested
        markdown-toc.condition.__raw = ''
          function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
            return false
          end
        '';
        # Only run the fixer when markdownlint reported something
        markdownlint-cli2.condition.__raw = ''
          function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end
        '';
      };
    };

    # Browser preview, toggled with <leader>cp in markdown buffers
    markdown-preview.enable = true;

    render-markdown = {
      enable = true;
      settings = {
        file_types = ["markdown" "norg" "rmd" "org"];
        code = {
          sign = false;
          width = "block";
          right_pad = 1;
        };
        heading = {
          sign = false;
          icons = [];
        };
        checkbox.enabled = false;
      };
    };
  };

  autoCmd = [
    {
      event = "FileType";
      pattern = "markdown";
      callback.__raw = ''
        function(args)
          vim.opt_local.wrap = true
          vim.opt_local.spell = true
          vim.keymap.set("n", "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", { buffer = args.buf, desc = "Markdown Preview" })
        end
      '';
    }
  ];

  extraConfigLua = ''
    Snacks.toggle({
      name = "Render Markdown",
      get = require("render-markdown").get,
      set = require("render-markdown").set,
    }):map("<leader>um")
  '';
}
