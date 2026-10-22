{
  config,
  pkgs,
  ...
}: {
  # rustaceanvim manages rust-analyzer; cargo and rustc come from the project toolchain
  plugins = {
    rustaceanvim = {
      enable = true;
      settings.server = {
        on_attach.__raw = ''
          function(_, bufnr)
            vim.keymap.set("n", "<leader>cR", function() vim.cmd.RustLsp("codeAction") end, { desc = "Code Action", buffer = bufnr })
            vim.keymap.set("n", "<leader>dr", function() vim.cmd.RustLsp("debuggables") end, { desc = "Rust Debuggables", buffer = bufnr })
          end
        '';
        default_settings.rust-analyzer = {
          cargo = {
            allFeatures = true;
            loadOutDirsFromCheck = true;
            buildScripts.enable = true;
          };
          checkOnSave = true;
          procMacro.enable = true;
        };
      };
    };

    crates = {
      enable = true;
      settings.lsp = {
        enabled = true;
        actions = true;
        completion = true;
        hover = true;
      };
    };

    neotest.settings.adapters = ["require('rustaceanvim.neotest')"];

    treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      rust
    ];
  };

  # Fallback only: a rust-analyzer matching the project toolchain (e.g. from rustup) wins
  extraPackagesAfter = [pkgs.rust-analyzer];
}
