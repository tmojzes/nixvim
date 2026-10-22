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
        terraform = ["terraform_fmt"];
        terraform-vars = ["terraform_fmt"];
        tf = ["terraform_fmt"];
      };
      # autoInstall would pick tenv; terraform itself is added below
      autoInstall.overrides.terraform_fmt = null;
    };

    treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      hcl
      terraform
    ];
  };

  # Fallback only: the project's terraform version wins
  extraPackagesAfter = [pkgs.terraform];
}
