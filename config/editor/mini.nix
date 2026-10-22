{
  plugins.mini = {
    enable = true;
    modules = {
      # Textobjects: af/if, ac/ic, ao/io (blocks), aa/ia (arguments), at/it (tags), au/iu (calls)
      ai = {
        n_lines = 500;
        custom_textobjects = {
          o.__raw = ''
            require("mini.ai").gen_spec.treesitter({
              a = { "@block.outer", "@conditional.outer", "@loop.outer" },
              i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            })
          '';
          f.__raw = ''require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })'';
          c.__raw = ''require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })'';
          t = ["<([%p%w]-)%f[^<%w][^<>]->.-</%1>" "^<.->().*()</[^/]->$"];
          d = ["%f[%d]%d+"];
          u.__raw = ''require("mini.ai").gen_spec.function_call()'';
          U.__raw = ''require("mini.ai").gen_spec.function_call({ name_pattern = "[%w_]" })'';
        };
      };
      comment = {};
      indentscope = {
        symbol = "│";
        options.try_as_border = true;
        draw.animation.__raw = ''require("mini.indentscope").gen_animation.none()'';
      };
      move = {};
      pairs = {};
      surround = {};
    };
  };

  autoCmd = [
    {
      event = "FileType";
      pattern = [
        "Trouble"
        "help"
        "snacks_dashboard"
        "snacks_notif"
        "snacks_terminal"
        "snacks_win"
        "trouble"
      ];
      callback.__raw = "function() vim.b.miniindentscope_disable = true end";
    }
  ];
}
