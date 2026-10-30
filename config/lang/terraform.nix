{
  config,
  pkgs,
  ...
}: {
  lsp.servers.terraformls.enable = true;

  plugins = {
    lint.lintersByFt.terraform = ["tflint"];

    conform-nvim = {
      settings.formatters_by_ft = {
        terraform = ["tofu_fmt"];
        terraform-vars = ["tofu_fmt"];
        tf = ["tofu_fmt"];
      };
      # opentofu itself is added below as a fallback
      autoInstall.overrides.tofu_fmt = null;
    };

    treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      hcl
      terraform
    ];
  };

  # Fallback only: the project's tofu version wins
  extraPackagesAfter = [pkgs.opentofu];
}
