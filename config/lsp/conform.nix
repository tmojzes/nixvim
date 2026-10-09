{
  plugins.conform-nvim = {
    enable = true;

    settings = {
      format_on_save = {
        lsp_fallback = true;
        timeout_ms = 3000;
      };

      notify_on_error = true;

      formatters = {
        ruff_format = {
          prepend_args = ["--line-length" "110"];
        };
        isort = {
          prepend_args = ["--line-length" "110"];
        };
        xmlstarlet = {
          args = ["fo"];
        };
      };

      formatters_by_ft = {
        python = ["isort" "ruff_format"];
        lua = ["stylua"];
        go = ["gofmt"];
        sh = ["shfmt"];
        proto = ["buf"];
        xml = ["xmlstarlet"];
        javascript = ["oxfmt"];
        typescript = ["oxfmt"];
        js = ["oxfmt"];
        ts = ["oxfmt"];
        nix = ["alejandra"];
      };
    };
  };
}
