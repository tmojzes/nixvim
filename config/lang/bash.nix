{pkgs, ...}: {
  # bashls runs shellcheck itself when it is on PATH
  lsp.servers.bashls.enable = true;
  extraPackages = [pkgs.shellcheck];

  plugins.conform-nvim.settings.formatters_by_ft = {
    sh = ["shfmt"];
    bash = ["shfmt"];
  };
}
