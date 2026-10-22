let
  flash = fn: "function() require('flash').${fn}() end";
in {
  plugins.flash.enable = true;

  keymaps = [
    {
      mode = ["n" "x" "o"];
      key = "s";
      action.__raw = flash "jump";
      options.desc = "Flash";
    }
    {
      mode = ["n" "x" "o"];
      key = "S";
      action.__raw = flash "treesitter";
      options.desc = "Flash Treesitter";
    }
    {
      mode = "o";
      key = "r";
      action.__raw = flash "remote";
      options.desc = "Remote Flash";
    }
    {
      mode = ["o" "x"];
      key = "R";
      action.__raw = flash "treesitter_search";
      options.desc = "Treesitter Search";
    }
    {
      mode = "c";
      key = "<c-s>";
      action.__raw = flash "toggle";
      options.desc = "Toggle Flash Search";
    }
  ];
}
