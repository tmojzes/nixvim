{
  # Linters are assigned per language in ./lang and installed by autoInstall
  plugins.lint = {
    enable = true;
    autoInstall.enable = true;

    # nvim-lint has no wildcard filetype, so codespell (from extraPackages) runs explicitly.
    # Scheduled because filetype detection runs after this autocmd on BufReadPost,
    # so the per-filetype linters would otherwise be skipped when a file is opened.
    autoCmd = {
      event = ["BufWritePost" "BufReadPost" "InsertLeave"];
      callback.__raw = ''
        function(args)
          vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(args.buf) then
              return
            end
            vim.api.nvim_buf_call(args.buf, function()
              local lint = require("lint")
              lint.try_lint()
              lint.try_lint("codespell")
            end)
          end)
        end
      '';
    };
  };
}
