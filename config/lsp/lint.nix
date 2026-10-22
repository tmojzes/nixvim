{
  # Linters are assigned per language in ./lang and installed by autoInstall
  plugins.lint = {
    enable = true;
    autoInstall.enable = true;

    # nvim-lint has no wildcard filetype, so codespell (from extraPackages) runs explicitly
    autoCmd = {
      event = ["BufWritePost" "BufReadPost" "InsertLeave"];
      callback.__raw = ''
        function()
          local lint = require("lint")
          lint.try_lint()
          lint.try_lint("codespell")
        end
      '';
    };
  };
}
