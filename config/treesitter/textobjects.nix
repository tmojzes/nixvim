let
  # Selection textobjects (af/if/ac/ic/aa/ia...) come from mini.ai; this only adds motions.
  # In diff mode ]c/[c keep their builtin meaning of jumping between changes.
  move = key: fn: query: desc: {
    mode = ["n" "x" "o"];
    inherit key;
    action.__raw = ''
      function()
        if vim.wo.diff and ("${key}"):find("[cC]") then
          return vim.cmd("normal! ${key}")
        end
        require("nvim-treesitter-textobjects.move").${fn}("${query}", "textobjects")
      end
    '';
    options.desc = desc;
  };
in {
  plugins.treesitter-textobjects.enable = true;

  keymaps = [
    (move "]f" "goto_next_start" "@function.outer" "Next Function Start")
    (move "]F" "goto_next_end" "@function.outer" "Next Function End")
    (move "[f" "goto_previous_start" "@function.outer" "Prev Function Start")
    (move "[F" "goto_previous_end" "@function.outer" "Prev Function End")
    (move "]c" "goto_next_start" "@class.outer" "Next Class Start")
    (move "]C" "goto_next_end" "@class.outer" "Next Class End")
    (move "[c" "goto_previous_start" "@class.outer" "Prev Class Start")
    (move "[C" "goto_previous_end" "@class.outer" "Prev Class End")
    (move "]a" "goto_next_start" "@parameter.inner" "Next Parameter")
    (move "[a" "goto_previous_start" "@parameter.inner" "Prev Parameter")
  ];
}
