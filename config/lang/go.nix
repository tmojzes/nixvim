{
  config,
  lib,
  pkgs,
  ...
}: {
  # gopls, goimports and neotest use the project's `go` from PATH
  lsp.servers.gopls = {
    enable = true;
    config.settings.gopls = {
      gofumpt = true;
      codelenses = {
        gc_details = false;
        generate = true;
        regenerate_cgo = true;
        run_govulncheck = true;
        test = true;
        tidy = true;
        upgrade_dependency = true;
        vendor = true;
      };
      hints = {
        assignVariableTypes = true;
        compositeLiteralFields = true;
        compositeLiteralTypes = true;
        constantValues = true;
        functionTypeParameters = true;
        parameterNames = true;
        rangeVariableTypes = true;
      };
      analyses = {
        nilness = true;
        unusedparams = true;
        unusedwrite = true;
        useany = true;
      };
      usePlaceholders = true;
      completeUnimported = true;
      staticcheck = true;
      directoryFilters = ["-.git" "-.vscode" "-.idea" "-.vscode-test" "-node_modules"];
      semanticTokens = true;
      # Load packages behind build tags as well:
      # buildFlags = ["-tags=integration global"];
    };
  };

  plugins = {
    conform-nvim.settings.formatters_by_ft.go = ["goimports" "gofumpt"];

    dap-go = {
      enable = true;
      settings.delve.path = lib.getExe pkgs.delve;
    };

    neotest.adapters.golang.enable = true;

    treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      go
      gomod
      gosum
      gowork
    ];
  };
}
