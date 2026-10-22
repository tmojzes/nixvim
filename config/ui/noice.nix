{
  plugins.noice = {
    enable = true;
    settings = {
      notify = {
        enabled = false;
      };
      messages = {
        enabled = true; # Adds a padding-bottom to neovim statusline when set to false for some reason
      };
      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
      };
      routes = [
        {
          filter = {
            event = "msg_show";
            any = [
              {find = "%d+L, %d+B";}
              {find = "; after #%d+";}
              {find = "; before #%d+";}
            ];
          };
          view = "mini";
        }
        {
          filter = {
            event = "notify";
            find = "No information available";
          };
          opts.skip = true;
        }
      ];
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        message = {
          enabled = true;
        };
        progress = {
          enabled = false;
          view = "mini";
        };
      };
      popupmenu = {
        enabled = true;
        backend = "nui";
      };
      format = {
        filter = {
          pattern = [":%s*%%s*s:%s*" ":%s*%%s*s!%s*" ":%s*%%s*s/%s*" "%s*s:%s*" ":%s*s!%s*" ":%s*s/%s*"];
          icon = "";
          lang = "regex";
        };
        replace = {
          pattern = [":%s*%%s*s:%w*:%s*" ":%s*%%s*s!%w*!%s*" ":%s*%%s*s/%w*/%s*" "%s*s:%w*:%s*" ":%s*s!%w*!%s*" ":%s*s/%w*/%s*"];
          icon = "󱞪";
          lang = "regex";
        };
      };
    };
  };
}
