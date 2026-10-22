let
  map = mode: key: action: desc: {
    inherit mode key action;
    options = {
      inherit desc;
      silent = true;
    };
  };
in {
  plugins.which-key = {
    enable = true;
    settings.spec = [
      {
        __unkeyed-1 = "<leader><tab>";
        group = "tabs";
      }
      {
        __unkeyed-1 = "<leader>b";
        group = "buffer";
      }
      {
        __unkeyed-1 = "<leader>c";
        group = "code";
        mode = ["n" "v"];
      }
      {
        __unkeyed-1 = "<leader>f";
        group = "file/find";
      }
      {
        __unkeyed-1 = "<leader>g";
        group = "git";
        mode = ["n" "v"];
      }
      {
        __unkeyed-1 = "<leader>gh";
        group = "hunks";
        mode = ["n" "v"];
      }
      {
        __unkeyed-1 = "<leader>q";
        group = "quit/session";
      }
      {
        __unkeyed-1 = "<leader>s";
        group = "search";
        mode = ["n" "v"];
      }
      {
        __unkeyed-1 = "<leader>u";
        group = "ui";
      }
      {
        __unkeyed-1 = "<leader>w";
        group = "windows";
        proxy = "<c-w>";
      }
      {
        __unkeyed-1 = "<leader>x";
        group = "diagnostics/quickfix";
      }
      {
        __unkeyed-1 = "[";
        group = "prev";
      }
      {
        __unkeyed-1 = "]";
        group = "next";
      }
      {
        __unkeyed-1 = "g";
        group = "goto";
      }
    ];
  };

  keymaps = [
    # Move over wrapped lines unless a count is given
    {
      mode = ["n" "x"];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        expr = true;
        silent = true;
        desc = "Down";
      };
    }
    {
      mode = ["n" "x"];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        expr = true;
        silent = true;
        desc = "Up";
      };
    }

    # Resize windows
    (map "n" "<C-Up>" "<cmd>resize +2<cr>" "Increase Window Height")
    (map "n" "<C-Down>" "<cmd>resize -2<cr>" "Decrease Window Height")
    (map "n" "<C-Left>" "<cmd>vertical resize -2<cr>" "Decrease Window Width")
    (map "n" "<C-Right>" "<cmd>vertical resize +2<cr>" "Increase Window Width")

    (map ["i" "n" "s"] "<esc>" "<cmd>noh<cr><esc>" "Escape and Clear hlsearch")
    (map ["i" "x" "n" "s"] "<C-s>" "<cmd>w<cr><esc>" "Save File")
    (map "x" "<" "<gv" "Indent Left")
    (map "x" ">" ">gv" "Indent Right")
    (map ["n" "v"] "<leader>D" ''"_d'' "Delete to void register")
    (map "n" "<leader>fn" "<cmd>enew<cr>" "New File")
    (map "n" "<leader>xl" "<cmd>lopen<cr>" "Location List")
    (map "n" "<leader>xq" "<cmd>copen<cr>" "Quickfix List")
    (map "n" "<leader>ui" "<cmd>Inspect<cr>" "Inspect Pos")
    (map "n" "<leader>uI" "<cmd>InspectTree<cr>" "Inspect Tree")
    (map "n" "<leader>qq" "<cmd>qa<cr>" "Quit All")

    # Windows
    (map "n" "<leader>-" "<C-W>s" "Split Window Below")
    (map "n" "<leader>|" "<C-W>v" "Split Window Right")
    (map "n" "<leader>wd" "<C-W>c" "Delete Window")

    # Tabs
    (map "n" "<leader><tab><tab>" "<cmd>tabnew<cr>" "New Tab")
    (map "n" "<leader><tab>d" "<cmd>tabclose<cr>" "Close Tab")
    (map "n" "<leader><tab>o" "<cmd>tabonly<cr>" "Close Other Tabs")
    (map "n" "<leader><tab>]" "<cmd>tabnext<cr>" "Next Tab")
    (map "n" "<leader><tab>[" "<cmd>tabprevious<cr>" "Previous Tab")
    (map "n" "<leader><tab>f" "<cmd>tabfirst<cr>" "First Tab")
    (map "n" "<leader><tab>l" "<cmd>tablast<cr>" "Last Tab")
  ];
}
