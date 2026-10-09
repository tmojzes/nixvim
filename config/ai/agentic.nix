{pkgs, ...}: {
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "agentic-nvim";
      version = "2024-10-09";
      src = pkgs.fetchFromGitHub {
        owner = "carlos-algms";
        repo = "agentic.nvim";
        rev = "e280deec82cfe642bba2c0d0157d320b706c094a";
        hash = "sha256-/zwKCvpuY+LeKO4B2fN0FXMXqBShI33HEiqiGxd90nk=";
      };
    })
  ];

  extraConfigLua = ''
    local function agentic()
      local a = require("agentic")
      if not _G.__agentic_setup_done then
        a.setup({ provider = "gemini-acp" })
        _G.__agentic_setup_done = true
      end
      return a
    end

    vim.keymap.set("n", "<leader>ac", function() agentic().toggle() end, { desc = "Toggle Agentic Chat" })
    vim.keymap.set({"n", "v"}, "<leader>aa", function() agentic().add_selection_or_file_to_context() end, { desc = "Add file or selection to Agentic to Context" })
    vim.keymap.set("n", "<leader>an", function() agentic().new_session() end, { desc = "New Agentic Session" })
    vim.keymap.set("n", "<leader>ar", function() agentic().restore_session() end, { desc = "Agentic Restore session", silent = true })
  '';
}
