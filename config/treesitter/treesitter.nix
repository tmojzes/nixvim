{config, ...}: {
  plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      highlight.enable = true;
      indent.enable = true;
      folding.enable = true;

      # Editor-wide grammars; language grammars are added in ./lang
      grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
        bash
        diff
        git_config
        git_rebase
        gitcommit
        gitignore
        json
        lua
        luadoc
        markdown
        markdown_inline
        printf
        query
        regex
        toml
        vim
        vimdoc
      ];
    };

    treesitter-context.enable = true;

    # Correct commentstring for embedded languages (tsx, templates, ...)
    ts-comments.enable = true;
  };
}
