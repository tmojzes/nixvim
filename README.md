# nixvim

A standalone, LazyVim-inspired Neovim configuration built with [Nixvim](https://github.com/nix-community/nixvim) and packaged as a flake. Every plugin, language server, formatter and linter is pinned by `flake.lock`, so nothing has to be installed globally.

```sh
nix run github:<owner>/nixvim   # or `nix run .` from a checkout
```

## Features

- **UI**: Gruvbox, Snacks.nvim dashboard / picker / explorer / notifier / terminal, lualine, bufferline, noice, dropbar, which-key
- **Editing**: blink.cmp with friendly-snippets and emoji, mini.ai / surround / pairs / move / comment, flash, yanky, grug-far, todo-comments, persistence, gitsigns, tmux navigation
- **Languages** (`config/lang/`): Kubernetes (yamlls + SchemaStore + CRD schema detection, Helm), JS/TS (ts_ls, oxlint, oxfmt), Go, Rust (rustaceanvim, crates), Python (pyright, ruff, venv-selector), C/C++ (clangd), Ansible, Bash, Terraform and Nix
- **Debugging and tests**: nvim-dap + dap-ui (delve, debugpy, codelldb) and neotest (Go, Python, Rust)
- **AI**: [agentic.nvim](https://github.com/carlos-algms/agentic.nvim)

Project toolchains (`go`, `cargo`/`rustc`, `terraform`, `kubectl`, `rust-analyzer`) are taken from your `PATH` or devshell first. `terraform`, `kubectl` and `rust-analyzer` are bundled only as fallbacks.

## Development

```sh
nix develop          # or `direnv allow`; provides nvim, alejandra, nixd, statix, deadnix
nix fmt              # format all Nix files with alejandra
nix flake check      # evaluate, build, launch headless, and check formatting
nix run .            # try the configuration
```

`<leader>fc` searches the files of this flake. Set `$NIXVIM_CONFIG_DIR` if the checkout isn't at `~/projects/personal/nixvim`.

## Layout

| Path | Contents |
|---|---|
| `config/options.nix`, `config/keymaps.nix` | Options and LazyVim core keymaps |
| `config/ui/`, `config/editor/` | UI and editing plugins with their keymaps |
| `config/lsp/` | Shared LSP, formatting (conform), linting (nvim-lint) and Trouble wiring |
| `config/lang/` | One file per language: servers, formatters, linters, debug/test adapters, grammars |
| `config/dap/`, `config/test/` | nvim-dap and neotest core |

To add a language, create `config/lang/<name>.nix` and import it in `config/lang/default.nix`.

## Keymaps

The keymaps follow LazyVim; press `<space>` and which-key lists them. Highlights:

| Key | Action |
|---|---|
| `<leader><space>`, `<leader>/` | Find files / grep (project root) |
| `<leader>e` | File explorer |
| `<leader>gg` | Lazygit |
| `<leader>sr` | Search and replace (grug-far) |
| `<leader>cf`, `<leader>uf` | Format / toggle format on save |
| `<leader>xx`, `<leader>cs` | Diagnostics / symbols (Trouble) |
| `<leader>d…`, `<leader>t…` | Debug / test |
| `<leader>k…` | Kubernetes schema refresh / info |
| `<leader>a…` | Agentic chat |
| `<C-/>` | Terminal |
