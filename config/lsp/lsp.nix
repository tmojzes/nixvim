let
  picker = source: "function() Snacks.picker.${source}() end";

  jump = key: count: severity: desc: {
    mode = "n";
    inherit key;
    action.__raw = "function() vim.diagnostic.jump({ count = ${count}, float = true, severity = ${severity} }) end";
    options.desc = desc;
  };
in {
  # Servers are enabled per language in ./lang; nvim-lspconfig provides their defaults
  plugins.lspconfig.enable = true;

  lsp.keymaps = [
    {
      key = "gd";
      action.__raw = picker "lsp_definitions";
      options.desc = "Goto Definition";
    }
    {
      key = "gD";
      action.__raw = picker "lsp_declarations";
      options.desc = "Goto Declaration";
    }
    {
      key = "gr";
      action.__raw = picker "lsp_references";
      options = {
        desc = "References";
        nowait = true;
      };
    }
    {
      key = "gI";
      action.__raw = picker "lsp_implementations";
      options.desc = "Goto Implementation";
    }
    {
      key = "gy";
      action.__raw = picker "lsp_type_definitions";
      options.desc = "Goto Type Definition";
    }
    {
      key = "gK";
      lspBufAction = "signature_help";
      options.desc = "Signature Help";
    }
    {
      mode = ["n" "v"];
      key = "<leader>ca";
      lspBufAction = "code_action";
      options.desc = "Code Action";
    }
    {
      key = "<leader>cr";
      lspBufAction = "rename";
      options.desc = "Rename";
    }
    {
      key = "<leader>cl";
      action = "<cmd>checkhealth vim.lsp<cr>";
      options.desc = "Lsp Info";
    }
    {
      key = "<leader>ss";
      action.__raw = picker "lsp_symbols";
      options.desc = "LSP Symbols";
    }
    {
      key = "<leader>sS";
      action.__raw = picker "lsp_workspace_symbols";
      options.desc = "LSP Workspace Symbols";
    }
  ];

  diagnostic.settings = {
    underline = true;
    update_in_insert = false;
    virtual_text = {
      spacing = 4;
      source = "if_many";
      prefix = "●";
    };
    severity_sort = true;
    signs.text.__raw = ''
      {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      }
    '';
  };

  # Diagnostics also come from linters, so these are global rather than LSP-only
  keymaps = [
    {
      mode = "n";
      key = "<leader>cd";
      action.__raw = "function() vim.diagnostic.open_float() end";
      options.desc = "Line Diagnostics";
    }
    (jump "]d" "1" "nil" "Next Diagnostic")
    (jump "[d" "-1" "nil" "Prev Diagnostic")
    (jump "]e" "1" "vim.diagnostic.severity.ERROR" "Next Error")
    (jump "[e" "-1" "vim.diagnostic.severity.ERROR" "Prev Error")
    (jump "]w" "1" "vim.diagnostic.severity.WARN" "Next Warning")
    (jump "[w" "-1" "vim.diagnostic.severity.WARN" "Prev Warning")
  ];
}
