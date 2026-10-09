{
  config = {
    opts = {
      # Line numbers
      number = true;
      relativenumber = false;

      # Tab and indentation
      tabstop = 4;
      softtabstop = 4;
      showtabline = 2;
      expandtab = true;
      smartindent = true;
      shiftwidth = 4;

      # Enable smart indenting
      breakindent = true;

      # Searching
      hlsearch = true;
      incsearch = true;
      ignorecase = true;
      smartcase = true; # Don't ignore case with capitals
      grepprg = "rg --vimgrep";
      grepformat = "%f:%l:%c:%m";

      # Clipboard
      clipboard = "unnamedplus";

      # Better splitting
      splitbelow = true;
      splitright = true;

      # Mouse mode
      mouse = "a";

      # Updatetime
      updatetime = 50;

      # Completion experience
      completeopt = ["menuone" "noselect" "noinsert"];

      # Undo history
      swapfile = false;
      backup = false;
      undofile = true;

      # 24-bit colors
      termguicolors = true;
      background = "dark";

      # Cursor line highlight
      cursorline = true;

      # Fold settings
      foldcolumn = "0";
      foldmethod = "indent";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;

      # Always keep 8 lines above/below cursor
      scrolloff = 8;

      # Column marker
      colorcolumn = "110";

      # Timeout for key sequences
      timeoutlen = 300;

      # Encoding
      encoding = "utf-8";
      fileencoding = "utf-8";

      # Command line display
      cmdheight = 0;
      showmode = false;
    };

    globals = {
      lazyvim_python_ruff = "ruff";
      lazyvim_python_lsp = "ruff";
    };

    extraConfigLua = ''
      -- Add templ file extension to support go templ.
      vim.filetype.add({
      	extension = {
      		templ = "templ",
      	},
      })

      -- Add filetypes for ansible.
      vim.filetype.add({
      	pattern = {
      		[".*/defaults/.*%.ya?ml"] = "yaml.ansible",
      		[".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
      		[".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
      		[".*/group_vars/.*/.*%.ya?ml"] = "yaml.ansible",
      		[".*/playbook.*%.ya?ml"] = "yaml.ansible",
      		[".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
      		[".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
      		[".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
      		[".*/tasks/.*%.ya?ml"] = "yaml.ansible",
      		[".*/molecule/.*%.ya?ml"] = "yaml.ansible",
      	},
      })

      -- Use OSC 52 for clipboard when SSHing (works in Ghostty + Tmux)
      if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
      	vim.g.clipboard = {
      		name = "OSC 52",
      		copy = {
      			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
      		},
      		paste = {
      			["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      			["*"] = require("vim.ui.clipboard.osc52").paste("*"),
      		},
      	}
      end
    '';
  };
}
