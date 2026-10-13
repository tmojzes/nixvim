{
  imports = [
    ./markdown-preview.nix
    ./render-markdown.nix
  ];

  filetype = {
    extension = {
      mdx = "markdown.mdx";
    };
  };
}
