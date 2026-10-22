{
  config,
  lib,
  pkgs,
  ...
}: {
  lsp.servers = {
    yamlls = {
      enable = true;
      config.settings.yaml = {
        keyOrdering = false;
        format.enable = true;
        validate = true;
      };
    };
    helm_ls.enable = true;
  };

  plugins = {
    schemastore = {
      enable = true;
      json.enable = lib.mkDefault false;
      yaml.enable = true;
    };

    # Detects Kubernetes resources (including CRDs from the current cluster) and applies their schema
    yaml-schema-detect = {
      enable = true;
      settings.keymap = {
        refresh = "<leader>kr";
        cleanup = "<leader>kc";
        info = "<leader>ki";
      };
    };

    # Detects the `helm` filetype for chart templates
    helm.enable = true;

    treesitter.grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      gotmpl
      helm
      yaml
    ];

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>k";
        group = "kubernetes";
      }
    ];
  };

  # Used by yaml-schema-detect
  extraPackages = with pkgs; [curl jq];
  # Fallback only: a kubectl already on PATH (and its context) wins
  extraPackagesAfter = [pkgs.kubectl];
}
