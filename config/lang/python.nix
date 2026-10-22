{config, ...}: {
  lsp.servers = {
    pyright.enable = true;
    ruff = {
      enable = true;
      # Hover comes from pyright
      config.on_attach.__raw = ''
        function(client)
          client.server_capabilities.hoverProvider = false
        end
      '';
    };
  };

  plugins = {
    conform-nvim.settings = {
      formatters_by_ft.python = ["isort" "ruff_format"];
      formatters = {
        isort.prepend_args = ["--line-length" "110"];
        # --line-length is a `ruff format` option, so it must follow the subcommand
        ruff_format.args = ["format" "--line-length" "110" "--force-exclude" "--stdin-filename" "$FILENAME" "-"];
      };
    };

    dap-python.enable = true;
    neotest.adapters.python.enable = true;
    venv-selector.enable = true;

    treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      python
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cv";
      action = "<cmd>VenvSelect<cr>";
      options.desc = "Select VirtualEnv";
    }
  ];
}
