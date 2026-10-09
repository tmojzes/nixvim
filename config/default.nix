{pkgs, ...}: {
  # Import all your configuration modules here
  imports = [
    ./plugins.nix
    ./colorscheme.nix
    ./keys.nix
    ./sets.nix
    ./lsp
    ./completion
    ./snippets
    ./ui
    ./treesitter
    ./ai
  ];

  extraPlugins = with pkgs.vimPlugins; [
    symbols-outline-nvim
  ];

  luaLoader.enable = true;

  performance = {
    byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      plugins = true;
      nvimRuntime = true;
    };
  };

  extraPackages = with pkgs; [
    codespell
    stylua
    shfmt
    shellcheck
    ruff
    isort
    alejandra
    ripgrep
    fd
    xmlstarlet
    buf
  ];
}
