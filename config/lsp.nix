{self, ...}: {
  plugins.lsp-format.enable = true;

  plugins.lsp = {
    enable = true;
    servers = {
      tsserver.enable = true;
      lua-ls.enable = true;
      rust-analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      bashls.enable = true;
      clangd.enable = true;
      dockerls.enable = true;
      gopls.enable = true;
      helm-ls.enable = true;
      html.enable = true;
      htmx.enable = true;
      golangci-lint-ls.enable = true;
      jsonls.enable = true;
      ocamllsp.enable = true;
      nixd.enable = true;
      pylsp.enable = true;
      pyright.enable = true;
      sqls.enable = true;
      tailwindcss.enable = true;
      templ.enable = true;
      terraformls.enable = true;
      yamlls.enable = true;
      zls.enable = true;
    };
  };
}
