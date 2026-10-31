{
  config,
  pkgs,
  ...
}: {
  # Neovim detects *.h as cpp by default
  globals.c_syntax_for_h = 1;

  lsp.servers.clangd = {
    enable = true;
    config.cmd = [
      "clangd"
      "--background-index"
      "--clang-tidy"
      "--header-insertion=iwyu"
      "--completion-style=detailed"
      "--function-arg-placeholders"
      "--fallback-style=llvm"
    ];
  };

  # AST, memory layout, type hierarchy and symbol info views from clangd's off-spec extensions
  plugins.clangd-extensions.enable = true;

  # codelldb debugs C, C++ and Rust (rustaceanvim picks it up from PATH).
  # Only the vscode-lldb extension is a Hydra job; its adapter output is never cached,
  # so expose the codelldb bundled inside the (cached) extension instead
  plugins.dap-lldb.enable = true;
  extraPackages = [
    (pkgs.writeShellScriptBin "codelldb" ''
      exec ${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb "$@"
    '')
  ];

  plugins.treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
    c
    cmake
    cpp
    make
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>ch";
      action = "<cmd>LspClangdSwitchSourceHeader<cr>";
      options.desc = "Switch Source/Header (C/C++)";
    }
    {
      mode = "n";
      key = "<leader>cA";
      action = "<cmd>ClangdAST<cr>";
      options.desc = "AST (C/C++)";
    }
    {
      mode = "n";
      key = "<leader>cM";
      action = "<cmd>ClangdMemoryUsage<cr>";
      options.desc = "Memory Usage (C/C++)";
    }
  ];
}
