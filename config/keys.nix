{
  globals.mapleader = " ";

  keymaps = [
    # General maps
    {
      mode = "n";
      key = "<leader>f";
      action = "+find/file";
    }

    {
      mode = "n";
      key = "<leader>s";
      action = "+search";
    }

    {
      mode = "n";
      key = "<leader>q";
      action = "+quit/session";
    }

    {
      mode = ["n" "v"];
      key = "<leader>g";
      action = "+git";
    }

    {
      mode = ["n" "v"];
      key = "<leader>gh";
      action = "+hunks";
    }

    {
      mode = "n";
      key = "<leader>u";
      action = "+ui";
    }

    {
      mode = "n";
      key = "<leader>w";
      action = "+windows";
    }

    {
      mode = "n";
      key = "<leader><Tab>";
      action = "+tab";
    }

    {
      mode = ["n" "v"];
      key = "<leader>d";
      action = "+debug";
    }

    {
      mode = ["n" "v"];
      key = "<leader>c";
      action = "+code";
    }

    {
      mode = ["n" "v"];
      key = "<leader>t";
      action = "+test";
    }

    # Tabs
    {
      mode = "n";
      key = "<leader><tab><tab>";
      action = "<cmd>tabnew<cr>";
      options = {
        silent = true;
        desc = "New Tab";
      };
    }

    {
      mode = "n";
      key = "<leader><tab>d";
      action = "<cmd>tabclose<cr>";
      options = {
        silent = true;
        desc = "Close tab";
      };
    }

    # Windows
    {
      mode = "n";
      key = "<leader>ww";
      action = "<C-W>p";
      options = {
        silent = true;
        desc = "Other window";
      };
    }

    {
      mode = "n";
      key = "<leader>wd";
      action = "<C-W>c";
      options = {
        silent = true;
        desc = "Delete window";
      };
    }

    {
      mode = "n";
      key = "<leader>w-";
      action = "<C-W>s";
      options = {
        silent = true;
        desc = "Split window below";
      };
    }

    {
      mode = "n";
      key = "<leader>w|";
      action = "<C-W>v";
      options = {
        silent = true;
        desc = "Split window right";
      };
    }

    # Visual mode paste without overwriting register
    {
      mode = "x";
      key = "p";
      action = "P";
      options = {
        desc = "Paste without yanking selected text";
      };
    }

    # Clear search and stop snippet on escape
    {
      mode = ["i" "n" "s"];
      key = "<esc>";
      action.__raw = ''
        function()
          vim.cmd("noh")
          if vim.snippet then
            vim.snippet.stop()
          end
          if package.loaded.luasnip and package.loaded.luasnip.expand_or_jumpable() then
            package.loaded.luasnip.unlink_current()
          end
          return "<esc>"
        end
      '';
      options = {
        expr = true;
        desc = "Escape and Clear hlsearch";
      };
    }

    # AI (Agentic)
    {
      mode = "n";
      key = "<leader>a";
      action = "+ai";
    }

    {
      mode = "n";
      key = "<leader>ac";
      action = "<cmd>lua require('agentic').toggle()<cr>";
      options = {
        desc = "Toggle Agentic Chat";
      };
    }

    {
      mode = ["n" "v"];
      key = "<leader>aa";
      action = "<cmd>lua require('agentic').add_selection_or_file_to_context()<cr>";
      options = {
        desc = "Add file or selection to Agentic Context";
      };
    }

    {
      mode = "n";
      key = "<leader>an";
      action = "<cmd>lua require('agentic').new_session()<cr>";
      options = {
        desc = "New Agentic Session";
      };
    }

    {
      mode = "n";
      key = "<leader>ar";
      action = "<cmd>lua require('agentic').restore_session()<cr>";
      options = {
        silent = true;
        desc = "Agentic Restore Session";
      };
    }

    # Symbols Outline
    {
      mode = "n";
      key = "<leader>cs";
      action = "<cmd>SymbolsOutline<cr>";
      options = {
        desc = "Symbols Outline";
      };
    }

    # Markdown Preview (browser)
    {
      mode = "n";
      key = "<leader>cp";
      action.__raw = ''
        function()
          if vim.fn.exists(":MarkdownPreviewToggle") == 2 then
            vim.cmd("MarkdownPreviewToggle")
          else
            vim.notify("Markdown Preview is only available for markdown files", vim.log.levels.WARN, { title = "Markdown Preview" })
          end
        end
      '';
      options = {
        desc = "Markdown Preview";
      };
    }

    # Yanky history
    {
      mode = "n";
      key = "<leader>p";
      action = "<cmd>Telescope yank_history<cr>";
      options = {
        desc = "Yank History";
      };
    }

    # Quit/Session
    {
      mode = "n";
      key = "<leader>qq";
      action = "<cmd>quitall<cr><esc>";
      options = {
        silent = true;
        desc = "Quit all";
      };
    }

    {
      mode = "n";
      key = "<leader>ul";
      action = ":lua ToggleLineNumber()<cr>";
      options = {
        silent = true;
        desc = "Toggle Line Numbers";
      };
    }

    {
      mode = "n";
      key = "<leader>uL";
      action = ":lua ToggleRelativeLineNumber()<cr>";
      options = {
        silent = true;
        desc = "Toggle Relative Line Numbers";
      };
    }

    {
      mode = "n";
      key = "<leader>uw";
      action = ":lua ToggleWrap()<cr>";
      options = {
        silent = true;
        desc = "Toggle Line Wrap";
      };
    }

    {
      mode = "n";
      key = "<leader>ur";
      action = "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
      options = {
        desc = "Redraw / Clear hlsearch / Diff Update";
      };
    }

    # Delete to void register
    {
      mode = ["n" "v"];
      key = "<leader>D";
      action = ''"_d'';
      options = {desc = "Delete to void register";};
    }

    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>lua Snacks.explorer()<cr>";
      options = {desc = "Explorer Snacks (root dir)";};
    }

    {
      mode = "n";
      key = "<leader>E";
      action = "<cmd>lua Snacks.explorer()<cr>";
      options = {desc = "Explorer Snacks (cwd)";};
    }

    {
      mode = "n";
      key = "<leader>fe";
      action = "<cmd>lua Snacks.explorer()<cr>";
      options = {desc = "Explorer Snacks (root dir)";};
    }

    {
      mode = "n";
      key = "<leader>fE";
      action = "<cmd>lua Snacks.explorer()<cr>";
      options = {desc = "Explorer Snacks (cwd)";};
    }

    {
      mode = "n";
      key = "<leader>fc";
      action = "<cmd>lua OpenNixvimConfig()<cr>";
      options = {desc = "Find Config File";};
    }

    # Terminal
    {
      mode = ["n" "t"];
      key = "<C-/>";
      action = "<cmd>lua Snacks.terminal()<cr>";
      options = {desc = "Toggle Terminal";};
    }

    {
      mode = ["n" "t"];
      key = "<C-_>";
      action = "<cmd>lua Snacks.terminal()<cr>";
      options = {desc = "Toggle Terminal";};
    }

    {
      mode = "n";
      key = "<leader>ft";
      action = "<cmd>lua Snacks.terminal()<cr>";
      options = {desc = "Terminal (Root Dir)";};
    }

    {
      mode = "n";
      key = "<leader>gg";
      action = "<CMD>LazyGit<CR>";
      options = {desc = "Open Lazygit";};
    }

    {
      mode = "n";
      key = "<leader>gb";
      action.__raw = "function() Snacks.picker.git_log_line() end";
      options = {desc = "Git Blame Line";};
    }

    {
      mode = ["n" "v"];
      key = "<leader>gB";
      action.__raw = "function() Snacks.gitbrowse() end";
      options = {desc = "Git Browse (open)";};
    }

    # Search and Replace (grug-far)
    {
      mode = ["n" "v"];
      key = "<leader>sr";
      action.__raw = ''
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end
      '';
      options = {desc = "Search and Replace";};
    }

    {
      mode = ["n" "v"];
      key = "<leader>sR";
      action.__raw = ''
        function()
          require("grug-far").open({
            transient = true,
          })
        end
      '';
      options = {desc = "Search and Replace (all files)";};
    }

    # Code formatting (conform)
    {
      mode = ["n" "v"];
      key = "<leader>cf";
      action.__raw = ''
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end
      '';
      options = {desc = "Format buffer";};
    }

    {
      mode = ["n" "v"];
      key = "<leader>cF";
      action.__raw = ''
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end
      '';
      options = {desc = "Format Injected Langs";};
    }

    # Flash navigation
    {
      mode = ["n" "x" "o"];
      key = "s";
      action.__raw = ''function() require("flash").jump() end'';
      options = {desc = "Flash";};
    }

    {
      mode = ["n" "x" "o"];
      key = "S";
      action.__raw = ''function() require("flash").treesitter() end'';
      options = {desc = "Flash Treesitter";};
    }

    {
      mode = "o";
      key = "r";
      action.__raw = ''function() require("flash").remote() end'';
      options = {desc = "Remote Flash";};
    }
  ];
  extraConfigLua = ''
    function ToggleLineNumber()
    if vim.wo.number then
      vim.wo.number = false
    else
      vim.wo.number = true
        vim.wo.relativenumber = false
        end
        end

        function ToggleRelativeLineNumber()
        if vim.wo.relativenumber then
          vim.wo.relativenumber = false
        else
          vim.wo.relativenumber = true
            vim.wo.number = false
            end
            end

            function ToggleWrap()
            vim.wo.wrap = not vim.wo.wrap
            end
  '';
}
