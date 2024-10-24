{
  plugins.treesitter = {
    enable = true;
    folding = true;
    nixvimInjections = true;

    settings = {
      indent.enable = true;
    };
  };

  plugins.treesitter-context.enable = true;
}
