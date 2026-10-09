{
  plugins.treesitter = {
    enable = true;
    nixvimInjections = true;

    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
  };

  plugins.treesitter-context.enable = true;
}
