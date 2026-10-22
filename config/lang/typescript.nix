{
  config,
  lib,
  ...
}: {
  lsp.servers = {
    ts_ls.enable = true;
    oxlint.enable = true;
    # package.json, tsconfig.json, ...
    jsonls.enable = true;
  };

  plugins = {
    schemastore = {
      enable = true;
      json.enable = true;
      yaml.enable = lib.mkDefault false;
    };

    conform-nvim.settings.formatters_by_ft = {
      javascript = ["oxfmt"];
      javascriptreact = ["oxfmt"];
      typescript = ["oxfmt"];
      typescriptreact = ["oxfmt"];
    };

    ts-autotag.enable = true;

    treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      html
      javascript
      jsdoc
      tsx
      typescript
    ];
  };
}
