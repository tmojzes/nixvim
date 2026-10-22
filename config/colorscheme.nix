{pkgs, ...}: {
  colorschemes.gruvbox.enable = true;

  # Additional themes from dotfiles, selectable with <leader>uC
  extraPlugins = with pkgs.vimPlugins; [
    adwaita-nvim
    catppuccin-nvim
    github-nvim-theme
    kanagawa-nvim
    vscode-nvim
  ];

  extraConfigLua = ''
    vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { link = "GruvboxYellow" })
  '';
}
