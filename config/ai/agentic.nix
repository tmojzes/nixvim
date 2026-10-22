{pkgs, ...}: let
  agentic = fn: "function() require('agentic').${fn}() end";
in {
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "agentic-nvim";
      version = "0-unstable-e280dee";
      src = pkgs.fetchFromGitHub {
        owner = "carlos-algms";
        repo = "agentic.nvim";
        rev = "e280deec82cfe642bba2c0d0157d320b706c094a";
        hash = "sha256-/zwKCvpuY+LeKO4B2fN0FXMXqBShI33HEiqiGxd90nk=";
      };
    })
  ];

  extraConfigLua = ''
    require("agentic").setup({ provider = "gemini-acp" })
  '';

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>a";
      group = "ai";
      mode = ["n" "v"];
    }
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>ac";
      action.__raw = agentic "toggle";
      options.desc = "Toggle Agentic Chat";
    }
    {
      mode = ["n" "v"];
      key = "<leader>aa";
      action.__raw = agentic "add_selection_or_file_to_context";
      options.desc = "Add File or Selection to Agentic Context";
    }
    {
      mode = "n";
      key = "<leader>an";
      action.__raw = agentic "new_session";
      options.desc = "New Agentic Session";
    }
    {
      mode = "n";
      key = "<leader>ar";
      action.__raw = agentic "restore_session";
      options = {
        silent = true;
        desc = "Agentic Restore Session";
      };
    }
  ];
}
