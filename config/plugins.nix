{
  plugins = {
    telescope.enable = true;
    oil.enable = true;
    treesitter.enable = true;
    treesitter-context.enable = true;
    luasnip.enable = true;
    lazygit.enable = true;
    which-key.enable = true;
    web-devicons.enable = true;
    flash.enable = true;

    # Grug-far search and replace
    grug-far = {
      enable = true;
      settings = {
        headerMaxWidth = 80;
      };
    };

    # Gitsigns
    gitsigns = {
      enable = true;
      settings = {
        signs = {
          add = {text = "▎";};
          change = {text = "▎";};
          delete = {text = "";};
          topdelete = {text = "";};
          changedelete = {text = "▎";};
          untracked = {text = "▎";};
        };
      };
    };

    # Snacks.nvim providing Dashboard, Explorer, Indent guides, Picker, and more
    snacks = {
      enable = true;
      settings = {
        indent = {
          enabled = true;
          scope.enabled = false;
        };
        input.enabled = true;
        notifier.enabled = true;
        scope.enabled = false;
        scroll.enabled = true;
        statuscolumn.enabled = false;
        words.enabled = true;
        picker.enabled = true;
        explorer.enabled = true;
        terminal.enabled = true;
        dashboard = {
          enabled = true;
          preset = {
            header = ''
              ████████╗███╗   ███╗ ██████╗      ██╗███████╗███████╗███████╗   ███╗   ██╗██╗   ██╗██╗███╗   ███╗
              ╚══██╔══╝████╗ ████║██╔═══██╗     ██║╚══███╔╝██╔════╝██╔════╝   ████╗  ██║██║   ██║██║████╗ ████║
                 ██║   ██╔████╔██║██║   ██║     ██║  ███╔╝ █████╗  ███████╗   ██╔██╗ ██║██║   ██║██║██╔████╔██║
                 ██║   ██║╚██╔╝██║██║   ██║██   ██║ ███╔╝  ██╔══╝  ╚════██║   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
                 ██║   ██║ ╚═╝ ██║╚██████╔╝╚█████╔╝███████╗███████╗███████║██╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
                 ╚═╝   ╚═╝     ╚═╝ ╚═════╝  ╚════╝ ╚══════╝╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
            '';
            keys = [
              {
                icon = " ";
                key = "f";
                desc = "Find File";
                action = ":lua Snacks.dashboard.pick('files')";
              }
              {
                icon = " ";
                key = "n";
                desc = "New File";
                action = ":ene | startinsert";
              }
              {
                icon = "󰏚 ";
                key = "p";
                desc = "Projects";
                action = ":lua Snacks.picker.projects()";
              }
              {
                icon = " ";
                key = "g";
                desc = "Find Text";
                action = ":lua Snacks.dashboard.pick('live_grep')";
              }
              {
                icon = " ";
                key = "r";
                desc = "Recent Files";
                action = ":lua Snacks.dashboard.pick('oldfiles')";
              }
              {
                icon = " ";
                key = "c";
                desc = "Config";
                action = ":lua OpenNixvimConfig()";
              }
              {
                icon = " ";
                key = "s";
                desc = "Restore Session";
                action = ":lua require('persistence').load()";
              }
              {
                icon = " ";
                key = "x";
                desc = "Lazy Extras";
                action = ":LazyExtras";
              }
              {
                icon = "󰒲 ";
                key = "l";
                desc = "Lazy";
                action = ":Lazy";
              }
              {
                icon = " ";
                key = "q";
                desc = "Quit";
                action = ":qa";
              }
            ];
          };
        };
      };
    };

    # Navigation for tmux
    tmux-navigator.enable = true;

    # Yanky clipboard support
    yanky = {
      enable = true;
      enableTelescope = true;
    };

    # DAP (Debug Adapter Protocol)
    dap.enable = true;
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
    dap-go.enable = true;
    dap-python.enable = true;

    # Testing
    neotest.enable = true;

    # Lualine matching LazyVim exactly
    lualine = {
      enable = true;
      settings = {
        options = {
          theme = "auto";
          globalstatus = true;
          disabled_filetypes = {
            statusline = [
              "dashboard"
              "alpha"
              "snacks_dashboard"
            ];
          };
        };
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch"];
          lualine_c = [
            {
              __unkeyed-1 = "diagnostics";
              symbols = {
                error = " ";
                warn = " ";
                info = " ";
                hint = " ";
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
                added = " ";
                modified = " ";
                removed = " ";
              };
            }
            "😄"
          ];
          lualine_y = [
            "progress"
            "location"
          ];
          lualine_z = [
            {
              __raw = ''function() return " " .. os.date("%R") end'';
            }
          ];
        };
      };
    };

    # Neo-tree file filtering (can still be used via Neo-tree command)
    neo-tree = {
      enable = true;
      settings = {
        filesystem = {
          filtered_items = {
            visible = false;
            show_hidden_count = true;
            hide_dotfiles = true;
            hide_gitignored = true;
            hide_by_name = [
              ".git"
              ".DS_Store"
            ];
            never_show = [];
          };
        };
      };
    };

    # Mini modules
    mini = {
      enable = true;
      modules = {
        indentscope = {
          symbol = "│";
          options = {
            try_as_border = true;
          };
          draw.__raw = ''{ animation = require("mini.indentscope").gen_animation.none() }'';
        };
        surround = {};
        comment = {};
        move = {};
        pairs = {};
      };
    };

    # Todo comments
    todo-comments = {
      enable = true;
      settings = {
        highlight = {
          multiline = true;
          multiline_pattern = "^.";
          multiline_context = 10;
          before = "";
          keyword = "wide";
          after = "fg";
          pattern = ''.*<((KEYWORDS)%(\(.{-1,}\))?):'';
          comments_only = true;
          max_line_len = 400;
          exclude = [];
        };
        search = {
          command = "rg";
          args = [
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
          ];
          pattern = ''\b(KEYWORDS)(\(\w*\))*:'';
        };
      };
    };

    # Session management
    persistence.enable = true;
  };

  extraConfigLua = ''
    -- Mock lazy.stats and lazy.status for Snacks dashboard and lualine
    package.preload["lazy.stats"] = function()
      return {
        stats = function()
          return {
            count = 73,
            loaded = 17,
            startuptime = 89.05,
          }
        end,
      }
    end
    package.preload["lazy.status"] = function()
      return {
        has_updates = function() return false end,
        updates = function() return "" end,
      }
    end

    -- User commands for Lazy on dashboard
    vim.api.nvim_create_user_command("Lazy", function()
      Snacks.notify.info("All plugins are managed declaratively via Nixvim.", { title = "Lazy" })
    end, { desc = "Nixvim plugin manager status" })

    vim.api.nvim_create_user_command("LazyExtras", function()
      Snacks.notify.info("Manage extras and configurations declaratively in your Nixvim flake.", { title = "Lazy Extras" })
    end, { desc = "Nixvim extras" })

    -- Open Nixvim / user config directory in Snacks picker
    local function get_config_dir()
      local candidates = {}
      if vim.env.NIXVIM_CONFIG_DIR then
        table.insert(candidates, vim.env.NIXVIM_CONFIG_DIR)
      end
      if vim.fn.isdirectory(vim.fn.stdpath("config")) == 1 then
        table.insert(candidates, vim.fn.stdpath("config"))
      end
      table.insert(candidates, vim.fn.expand("~/projects/personal/nixvim"))
      table.insert(candidates, vim.fn.expand("~/.config/nixvim"))
      table.insert(candidates, vim.fn.expand("~/dotfiles/nvim/.config/nvim"))
      table.insert(candidates, vim.fn.expand("~/dotfiles/nix"))
      table.insert(candidates, vim.fn.expand("~/dotfiles"))

      for _, dir in ipairs(candidates) do
        if dir and dir ~= "" and vim.fn.isdirectory(dir) == 1 then
          return dir
        end
      end
      return nil
    end

    _G.OpenNixvimConfig = function()
      local dir = get_config_dir()
      if dir then
        Snacks.dashboard.pick("files", { cwd = dir })
      else
        Snacks.notify.warn("Config directory not found. Please set $NIXVIM_CONFIG_DIR or ensure the config directory exists.", { title = "Config" })
      end
    end

    -- Hide statusline on the dashboard starter page, restore on buffer enter
    if vim.fn.argc(-1) == 0 then
      vim.o.laststatus = 0
    end
    vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
      callback = function()
        if vim.bo.filetype ~= "snacks_dashboard" and vim.bo.filetype ~= "dashboard" and vim.bo.filetype ~= "alpha" then
          vim.o.laststatus = 3
        end
      end,
    })

    -- Disable mini.indentscope on dashboard and non-code filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "Trouble",
        "alpha",
        "dashboard",
        "fzf",
        "help",
        "lazy",
        "mason",
        "neo-tree",
        "notify",
        "sidekick_terminal",
        "snacks_dashboard",
        "snacks_notif",
        "snacks_terminal",
        "snacks_win",
        "toggleterm",
        "trouble",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "SnacksDashboardOpened",
      callback = function(data)
        vim.b[data.buf].miniindentscope_disable = true
      end,
    })
  '';
}
