{
  plugins.grug-far = {
    enable = true;
    settings.headerMaxWidth = 80;
  };

  keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>sr";
      # Limit the search to the current file's extension
      action.__raw = ''
        function()
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          require("grug-far").open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end
      '';
      options.desc = "Search and Replace";
    }
  ];
}
