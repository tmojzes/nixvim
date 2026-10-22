{
  globals = {
    mapleader = " ";
    maplocalleader = "\\";
    # Format on save; toggled with <leader>uf / <leader>uF
    autoformat = true;
  };

  opts = {
    # Line numbers
    number = true;
    relativenumber = false;
    signcolumn = "yes";

    # Tab and indentation
    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    smartindent = true;
    breakindent = true;

    # Searching
    ignorecase = true;
    smartcase = true;
    grepprg = "rg --vimgrep";
    grepformat = "%f:%l:%c:%m";

    clipboard = "unnamedplus";
    splitbelow = true;
    splitright = true;
    mouse = "a";
    updatetime = 200;
    timeoutlen = 300;
    completeopt = ["menuone" "noselect" "noinsert"];

    swapfile = false;
    undofile = true;

    background = "dark";
    cursorline = true;
    scrolloff = 8;
    colorcolumn = "110";
    winborder = "rounded";

    # Folds come from treesitter; start with everything open
    foldlevel = 99;
    foldlevelstart = 99;

    cmdheight = 0;
    showmode = false;
  };

  extraConfigLuaPre = ''
    -- Use OSC 52 for the clipboard over SSH (works in Ghostty + tmux)
    if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
      local osc52 = require("vim.ui.clipboard.osc52")
      vim.g.clipboard = {
        name = "OSC 52",
        copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
        paste = { ["+"] = osc52.paste("+"), ["*"] = osc52.paste("*") },
      }
    end
  '';
}
