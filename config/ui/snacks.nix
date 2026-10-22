let
  # The project root is the closest .git directory, falling back to the cwd
  root = "vim.fs.root(0, '.git')";

  map = mode: key: action: desc: {
    inherit mode key;
    action.__raw = action;
    options.desc = desc;
  };
  pick = key: source: desc: map "n" key "function() Snacks.picker.${source}() end" desc;
  pickRoot = key: source: desc: map "n" key "function() Snacks.picker.${source}({ cwd = ${root} }) end" desc;
in {
  plugins.snacks = {
    enable = true;
    settings = {
      bigfile.enabled = true;
      explorer.enabled = true;
      indent = {
        enabled = true;
        # mini.indentscope draws the scope
        scope.enabled = false;
      };
      input.enabled = true;
      notifier.enabled = true;
      # Hidden and ignored files are toggled with <M-h> / <M-i> inside pickers and the explorer
      picker.enabled = true;
      quickfile.enabled = true;
      scope.enabled = false;
      scroll.enabled = true;
      statuscolumn.enabled = false;
      terminal.enabled = true;
      words.enabled = true;

      dashboard = {
        enabled = true;
        sections = [
          {section = "header";}
          {
            section = "keys";
            gap = 1;
            padding = 1;
          }
        ];
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
              icon = " ";
              key = "f";
              desc = "Find File";
              action = ":lua Snacks.dashboard.pick('files')";
            }
            {
              icon = " ";
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
              icon = " ";
              key = "g";
              desc = "Find Text";
              action = ":lua Snacks.dashboard.pick('live_grep')";
            }
            {
              icon = " ";
              key = "r";
              desc = "Recent Files";
              action = ":lua Snacks.dashboard.pick('oldfiles')";
            }
            {
              icon = " ";
              key = "c";
              desc = "Config";
              action = ":lua OpenNixvimConfig()";
            }
            {
              icon = " ";
              key = "s";
              desc = "Restore Session";
              action = ":lua require('persistence').load()";
            }
            {
              icon = " ";
              key = "q";
              desc = "Quit";
              action = ":qa";
            }
          ];
        };
      };
    };
  };

  keymaps = [
    # Top level
    (pickRoot "<leader><space>" "files" "Find Files (Root Dir)")
    (pickRoot "<leader>/" "grep" "Grep (Root Dir)")
    (pick "<leader>," "buffers" "Buffers")
    (pick "<leader>:" "command_history" "Command History")
    (map "n" "<leader>n" "function() Snacks.picker.notifications() end" "Notification History")
    (map "n" "<leader>un" "function() Snacks.notifier.hide() end" "Dismiss All Notifications")

    # Explorer
    (map "n" "<leader>e" "function() Snacks.explorer({ cwd = ${root} }) end" "Explorer (Root Dir)")
    (map "n" "<leader>E" "function() Snacks.explorer() end" "Explorer (cwd)")
    (map "n" "<leader>fe" "function() Snacks.explorer({ cwd = ${root} }) end" "Explorer (Root Dir)")
    (map "n" "<leader>fE" "function() Snacks.explorer() end" "Explorer (cwd)")

    # Find
    (pick "<leader>fb" "buffers" "Buffers")
    (map "n" "<leader>fc" "function() OpenNixvimConfig() end" "Find Config File")
    (pickRoot "<leader>ff" "files" "Find Files (Root Dir)")
    (pick "<leader>fF" "files" "Find Files (cwd)")
    (pick "<leader>fg" "git_files" "Find Files (git-files)")
    (pick "<leader>fr" "recent" "Recent")
    (map "n" "<leader>fR" "function() Snacks.picker.recent({ filter = { cwd = true } }) end" "Recent (cwd)")
    (pick "<leader>fp" "projects" "Projects")

    # Git
    (map "n" "<leader>gg" "function() Snacks.lazygit({ cwd = ${root} }) end" "Lazygit (Root Dir)")
    (map "n" "<leader>gG" "function() Snacks.lazygit() end" "Lazygit (cwd)")
    (pick "<leader>gd" "git_diff" "Git Diff (hunks)")
    (pick "<leader>gs" "git_status" "Git Status")
    (pick "<leader>gS" "git_stash" "Git Stash")
    (pickRoot "<leader>gl" "git_log" "Git Log")
    (pick "<leader>gL" "git_log" "Git Log (cwd)")
    (pick "<leader>gb" "git_log_line" "Git Blame Line")
    (pick "<leader>gf" "git_log_file" "Git Current File History")
    (map ["n" "x"] "<leader>gB" "function() Snacks.gitbrowse() end" "Git Browse (open)")

    # Search
    (pick "<leader>s\"" "registers" "Registers")
    (pick "<leader>s/" "search_history" "Search History")
    (pick "<leader>sa" "autocmds" "Autocmds")
    (pick "<leader>sb" "lines" "Buffer Lines")
    (pick "<leader>sB" "grep_buffers" "Grep Open Buffers")
    (pick "<leader>sc" "command_history" "Command History")
    (pick "<leader>sC" "commands" "Commands")
    (pick "<leader>sd" "diagnostics" "Diagnostics")
    (pick "<leader>sD" "diagnostics_buffer" "Buffer Diagnostics")
    (pickRoot "<leader>sg" "grep" "Grep (Root Dir)")
    (pick "<leader>sG" "grep" "Grep (cwd)")
    (pick "<leader>sh" "help" "Help Pages")
    (pick "<leader>sH" "highlights" "Highlights")
    (pick "<leader>si" "icons" "Icons")
    (pick "<leader>sj" "jumps" "Jumps")
    (pick "<leader>sk" "keymaps" "Keymaps")
    (pick "<leader>sl" "loclist" "Location List")
    (pick "<leader>sm" "marks" "Marks")
    (pick "<leader>sM" "man" "Man Pages")
    (pick "<leader>sq" "qflist" "Quickfix List")
    (pick "<leader>sR" "resume" "Resume")
    (pick "<leader>su" "undo" "Undotree")
    (map ["n" "x"] "<leader>sw" "function() Snacks.picker.grep_word({ cwd = ${root} }) end" "Visual selection or word (Root Dir)")
    (map ["n" "x"] "<leader>sW" "function() Snacks.picker.grep_word() end" "Visual selection or word (cwd)")
    (pick "<leader>uC" "colorschemes" "Colorschemes")

    # Terminal
    (map "n" "<leader>ft" "function() Snacks.terminal(nil, { cwd = ${root} }) end" "Terminal (Root Dir)")
    (map "n" "<leader>fT" "function() Snacks.terminal() end" "Terminal (cwd)")
    (map "n" "<C-/>" "function() Snacks.terminal(nil, { cwd = ${root} }) end" "Terminal (Root Dir)")
    (map "n" "<C-_>" "function() Snacks.terminal(nil, { cwd = ${root} }) end" "which_key_ignore")
    {
      mode = "t";
      key = "<C-/>";
      action = "<cmd>close<cr>";
      options.desc = "Hide Terminal";
    }
    {
      mode = "t";
      key = "<C-_>";
      action = "<cmd>close<cr>";
      options.desc = "which_key_ignore";
    }
  ];

  extraConfigLua = ''
    -- Find files in this flake; set $NIXVIM_CONFIG_DIR when it lives elsewhere
    function OpenNixvimConfig()
      local dir = vim.env.NIXVIM_CONFIG_DIR or vim.fn.expand("~/projects/personal/nixvim")
      if vim.fn.isdirectory(dir) == 1 then
        Snacks.picker.files({ cwd = dir })
      else
        Snacks.notify.warn("Config directory not found: " .. dir .. ". Set $NIXVIM_CONFIG_DIR.", { title = "Config" })
      end
    end

    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    Snacks.toggle.line_number():map("<leader>ul")
    Snacks.toggle.diagnostics():map("<leader>ud")
    Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uc")
    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
    Snacks.toggle.treesitter():map("<leader>uT")
    Snacks.toggle.inlay_hints():map("<leader>uh")
    Snacks.toggle.indent():map("<leader>ug")
    Snacks.toggle.dim():map("<leader>uD")
    Snacks.toggle.zen():map("<leader>uz")
    Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
  '';
}
