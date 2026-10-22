{config, ...}: {
  lsp.servers.nixd.enable = true;

  plugins = {
    conform-nvim.settings.formatters_by_ft.nix = ["alejandra"];

    treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      nix
    ];
  };
}
