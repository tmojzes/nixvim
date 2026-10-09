{pkgs, ...}: {
  colorschemes.gruvbox = {
    enable = true;
  };

  # Additional themes from dotfiles available for preview/selection
  extraPlugins = with pkgs.vimPlugins; [
    catppuccin-nvim
    adwaita-nvim
    kanagawa-nvim
    vscode-nvim
    (pkgs.vimUtils.buildVimPlugin {
      pname = "github-nvim-theme";
      version = "c106c94";
      src = pkgs.fetchFromGitHub {
        owner = "projekt0n";
        repo = "github-nvim-theme";
        rev = "c106c9472154d6b2c74b74565616b877ae8ed31d";
        hash = "sha256-/A4hkKTzjzeoR1SuwwklraAyI8oMkhxrwBBV9xb59PA=";
      };
    })
  ];

  extraConfigLua = ''
    vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { link = "GruvboxYellow" })
  '';
}
