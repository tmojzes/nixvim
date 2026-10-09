{pkgs, ...}: {
  plugins = {
    lsp = {
      enable = true;
      inlayHints = false;

      servers = {
        ts_ls.enable = true;
        lua_ls.enable = true;

        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };

        bashls.enable = true;
        clangd.enable = true;
        dockerls.enable = true;
        gopls.enable = true;
        helm_ls.enable = true;
        html.enable = true;
        htmx.enable = true;
        jsonls.enable = true;
        nixd.enable = true;
        pyright.enable = true;
        ruff.enable = true;
        sqls.enable = true;
        templ.enable = true;
        terraformls.enable = true;
        yamlls.enable = true;
        zls.enable = true;
        ols.enable = true;
        ansiblels = {
          enable = true;
          package = pkgs.ansible-language-server;
        };
        jinja_lsp.enable = true;
        marksman.enable = true;
        elixirls.enable = false;

        cssls = {
          enable = true;
          filetypes = [
            "css"
            "scss"
            "less"
          ];
        };

        tailwindcss = {
          enable = true;
          rootMarkers = [
            ".git"
          ];
          filetypes = [
            "aspnetcorerazor"
            "astro"
            "astro-markdown"
            "blade"
            "clojure"
            "django-html"
            "htmldjango"
            "edge"
            "eelixir"
            "elixir"
            "ejs"
            "erb"
            "eruby"
            "gohtml"
            "gohtmltmpl"
            "haml"
            "handlebars"
            "hbs"
            "html"
            "html-eex"
            "heex"
            "jade"
            "leaf"
            "liquid"
            "markdown"
            "mdx"
            "mustache"
            "njk"
            "nunjucks"
            "php"
            "razor"
            "slim"
            "twig"
            "css"
            "less"
            "postcss"
            "sass"
            "scss"
            "stylus"
            "sugarss"
            "javascript"
            "javascriptreact"
            "reason"
            "rescript"
            "typescript"
            "typescriptreact"
            "vue"
            "svelte"
            "templ"
          ];
        };
      };

      keymaps = {
        silent = true;
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>cw" = {
            action = "workspace_symbol";
            desc = "Workspace Symbol";
          };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
        diagnostic = {
          "<leader>cd" = {
            action = "open_float";
            desc = "Line Diagnostics";
          };
          "[d" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "]d" = {
            action = "goto_prev";
            desc = "Previous Diagnostic";
          };
        };
      };
    };
  };

  extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
      config = vim.tbl_extend("force", config or {}, { border = _border })
      return vim.lsp.handlers.hover(err, result, ctx, config)
    end

    vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
      config = vim.tbl_extend("force", config or {}, { border = _border })
      return vim.lsp.handlers.signature_help(err, result, ctx, config)
    end

    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      severity_sort = true,
      float = {
        border = _border,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = " ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })

    -- Elixir Expert language server setup from dotfiles
    local configs = require("lspconfig.configs")
    if not configs.expert then
      configs.expert = {
        default_config = {
          cmd = { "expert" },
          filetypes = { "elixir", "eelixir", "heex", "surface" },
          root_dir = require("lspconfig.util").root_pattern("mix.exs", ".git"),
          settings = {},
        },
      }
    end
    require("lspconfig").expert.setup({
      cmd = { "expert" },
      filetypes = { "elixir", "eelixir", "heex", "surface" },
      root_dir = require("lspconfig.util").root_pattern("mix.exs", ".git"),
      settings = {},
    })
  '';
}
