{
  plugins.todo-comments = {
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

  keymaps = [
    {
      mode = "n";
      key = "]t";
      action.__raw = "function() require('todo-comments').jump_next() end";
      options.desc = "Next Todo Comment";
    }
    {
      mode = "n";
      key = "[t";
      action.__raw = "function() require('todo-comments').jump_prev() end";
      options.desc = "Previous Todo Comment";
    }
    {
      mode = "n";
      key = "<leader>st";
      action.__raw = "function() Snacks.picker.todo_comments() end";
      options.desc = "Todo";
    }
    {
      mode = "n";
      key = "<leader>sT";
      action.__raw = ''function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end'';
      options.desc = "Todo/Fix/Fixme";
    }
  ];
}
