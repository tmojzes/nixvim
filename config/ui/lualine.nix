{
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = "auto";
        globalstatus = true;
        disabled_filetypes.statusline = ["snacks_dashboard"];
      };
      sections = {
        lualine_a = ["mode"];
        lualine_b = ["branch"];
        lualine_c = [
          {
            __unkeyed-1 = "diagnostics";
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
              hint = " ";
            };
          }
          {
            __unkeyed-1 = "filetype";
            icon_only = true;
            separator = "";
            padding = {
              left = 1;
              right = 0;
            };
          }
          {
            __unkeyed-1 = "filename";
            path = 1;
          }
        ];
        lualine_x = [
          {
            __unkeyed-1 = "diff";
            symbols = {
              added = " ";
              modified = " ";
              removed = " ";
            };
          }
          "😄"
        ];
        lualine_y = ["progress" "location"];
        lualine_z = [
          {
            __raw = ''function() return " " .. os.date("%R") end'';
          }
        ];
      };
    };
  };

  # Hide the statusline on the startup dashboard; show it again once a real buffer is entered
  extraConfigLua = ''
    if vim.fn.argc(-1) == 0 then
      vim.o.laststatus = 0
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          if vim.bo.filetype ~= "snacks_dashboard" then
            vim.o.laststatus = 3
            return true
          end
        end,
      })
    end
  '';
}
