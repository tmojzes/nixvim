{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./options.nix
    ./keymaps.nix
    ./colorscheme.nix
    ./ai
    ./completion
    ./snippets
    ./treesitter
    ./lsp
    ./editor
    ./ui
    ./dap
    ./test
    ./lang
  ];

  # flake.nix makes nixvim follow our nixpkgs input
  nixpkgs.source = inputs.nixpkgs;

  # terraform is BSL (`terraform fmt`); cmp-emoji has no license in nixpkgs
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["cmp-emoji" "terraform"];

  luaLoader.enable = true;

  performance.byteCompileLua = {
    enable = true;
    configs = true;
    initLua = true;
    plugins = true;
    nvimRuntime = true;
  };

  # Shared CLI tools; language-specific tools live in ./lang
  extraPackages = with pkgs; [
    codespell
    fd
    lazygit
    ripgrep
  ];
}
