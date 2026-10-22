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

  # terraform is BSL; it is the only unfree package (`terraform fmt`)
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["terraform"];

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
