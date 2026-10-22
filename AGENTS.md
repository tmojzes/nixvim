# AGENTS.md

Instructions and guidelines for AI coding agents working on this repository.

---

## 1. Project Overview

This repository contains a standalone, modular **Nixvim** configuration packaged as a Nix Flake using `flake-parts`. It provides an optimized, LazyVim-inspired Neovim distribution with Gruvbox aesthetics, Snacks.nvim dashboard/picker/explorer, LSP, Treesitter, conform.nvim, and agentic integrations.

- **Framework**: [Nixvim](https://github.com/nix-community/nixvim) with `flake-parts`
- **Primary Language**: Nix (with embedded Lua configurations via Nixvim options)
- **Supported Systems**: `x86_64-linux`, `aarch64-linux`, `aarch64-darwin`

---

## 2. Directory Structure

```
.
├── flake.nix              # flake-parts: packages, checks (build test + format), formatter, devShell
├── flake.lock
├── README.md              # Human-facing overview
├── config/
│   ├── default.nix        # Root module: imports, shared extraPackages, performance, unfree allowlist
│   ├── options.nix        # Global options, leader keys, OSC52 clipboard over SSH
│   ├── keymaps.nix        # LazyVim core keymaps + which-key groups
│   ├── colorscheme.nix    # Gruvbox (default) + extra themes
│   ├── ai/                # agentic.nvim
│   ├── completion/        # blink.cmp + friendly-snippets + emoji
│   ├── treesitter/        # Treesitter, context, ts-comments, textobject motions
│   ├── lsp/               # Shared wiring: lspconfig + LSP keymaps, conform, nvim-lint, trouble
│   ├── editor/            # flash, gitsigns, grug-far, mini.*, persistence, todo-comments, yanky, tmux
│   ├── ui/                # Snacks (dashboard/picker/explorer/toggles/terminal), lualine, bufferline, noice, dropbar
│   ├── dap/               # nvim-dap core + keymaps
│   ├── test/              # neotest core + keymaps
│   └── lang/              # One file per language: servers, formatters, linters, dap/neotest adapters, grammars
```

---

## 3. Essential Commands

### Build & Run
- **Build the configuration**:
  ```bash
  nix build .
  ```
  *(Creates a symlink `./result` containing `./result/bin/nvim`)*

- **Run Neovim directly**:
  ```bash
  nix run .
  ```
  Or run the built derivation:
  ```bash
  ./result/bin/nvim
  ```

### Verification & Testing
- **Fast syntax & evaluation check**:
  ```bash
  nix flake check --no-build
  ```
- **Full flake check** (builds the config, launches it headless failing on startup errors/warnings, and checks formatting):
  ```bash
  nix flake check
  ```
- **Headless launch smoke-test** (verifies startup without Lua or runtime errors):
  ```bash
  nix run . -- --headless -c "qa"
  ```
  Or using the built binary:
  ```bash
  ./result/bin/nvim --headless -c "qa"
  ```

### Formatting & Flake Maintenance
- **Dev shell** (nvim, alejandra, nixd, statix, deadnix): `nix develop` or `direnv allow`
- **Format Nix files**:
  ```bash
  nix fmt
  ```
- **Update flake inputs**:
  ```bash
  nix flake update
  ```
  Or update a specific input:
  ```bash
  nix flake lock --update-input nixvim
  ```

---

## 4. Architectural Rules & Best Practices

1. **Native Nixvim Options First**:
   - Prefer native Nixvim plugin options (e.g. `plugins.<name>.enable = true; plugins.<name>.settings = { ... };`) over writing raw Lua.
   - Check Nixvim documentation or available option definitions before resorting to raw strings.

2. **Custom / Third-Party Plugins**:
   - If a plugin is packaged in `pkgs.vimPlugins`, add it to `extraPlugins = with pkgs.vimPlugins; [ ... ];`.
   - If a plugin is not in nixpkgs, package it using `pkgs.vimUtils.buildVimPlugin` with `pkgs.fetchFromGitHub` (as done in `config/ai/agentic.nix`).
   - Use `extraConfigLua` for plugin-specific Lua setup when native options are insufficient.

3. **Hermetic Dependencies & External Binaries**:
   - Never assume tools are installed globally on the user's system.
   - Language support lives in `config/lang/<language>.nix`: enable servers with the top-level `lsp.servers.<name>` option (set `package` when nixvim has none), and add formatters/linters to `plugins.conform-nvim.settings.formatters_by_ft` / `plugins.lint.lintersByFt`; their packages are installed by `autoInstall`.
   - Other binaries go in `extraPackages` of the module that needs them; shared CLI tools (`rg`, `fd`, `codespell`, `lazygit`) are in `config/default.nix`.
   - Project toolchains that must match the project version (`terraform`, `kubectl`, `rust-analyzer`) go in `extraPackagesAfter`, so a version on the user's `PATH` wins.

4. **Module Organization**:
   - Every directory inside `config/` should have a `default.nix` that aggregates and imports submodules.
   - When adding a new configuration file (e.g., `config/ui/statusline.nix`), ensure it is imported in `config/ui/default.nix`.

5. **Performance & Startup Time**:
   - Lua bytecode compilation (`performance.byteCompileLua`) and `luaLoader.enable = true` are active in `config/default.nix`.
   - Avoid heavy blocking computations or unnecessary file I/O at Neovim startup.

---

## 5. Coding & Contribution Conventions

- **Nix Code Style**: Two-space indentation, idiomatic Nix syntax, formatted via `alejandra`.
- **Git Commit Messages**: Follow Conventional Commits format:
  - `feat: ...` or `feat(<scope>): ...` (e.g., `feat(lang): add terraform support`)
  - `fix: ...` or `fix(<scope>): ...`
  - `chore: ...` or `chore(<scope>): ...`
- **Verification Requirement**: Always verify your changes before completing a task by running:
  1. `nix fmt`
  2. `nix flake check`
  3. `nix run . -- --headless -c "qa"`
