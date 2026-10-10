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
├── flake.nix              # Flake definitions, flake-parts config, checks & packages
├── flake.lock             # Flake lockfile
├── README.md              # Human-facing project overview
├── config/
│   ├── default.nix        # Root module: imports submodules, sets extraPackages & performance
│   ├── plugins.nix        # Primary plugins (Snacks.nvim, oil, grug-far, flash, gitsigns, etc.)
│   ├── keys.nix           # Keybindings (LazyVim-style mnemonic leader mappings)
│   ├── sets.nix           # Global Neovim options (tab stops, line numbers, clipboard, etc.)
│   ├── colorscheme.nix    # Theme definitions (Gruvbox default, Catppuccin, Kanagawa, etc.)
│   ├── ai/                # AI agent integrations (agentic.nvim)
│   ├── completion/        # nvim-cmp autocompletion engine and sources
│   ├── lsp/               # LSP servers, conform.nvim formatting, nvim-lint, trouble.nvim
│   ├── snippets/          # Luasnip snippets configuration
│   ├── treesitter/        # Treesitter highlighting and textobjects
│   └── ui/                # UI components (bufferline, dropbar, noice, notify, telescope)
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
- **Full flake check derivation**:
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
- **Format Nix files**:
  ```bash
  nix run nixpkgs#alejandra -- flake.nix config/
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
   - If a plugin is not in nixpkgs, package it using `pkgs.vimUtils.buildVimPlugin` with `pkgs.fetchFromGitHub` (as done in `config/ai/agentic.nix` and `config/colorscheme.nix`).
   - Use `extraConfigLua` for plugin-specific Lua setup when native options are insufficient.

3. **Hermetic Dependencies & External Binaries**:
   - Never assume tools are installed globally on the user's system.
   - Formatters (e.g., `stylua`, `alejandra`, `ruff`, `shfmt`), linters (e.g., `codespell`), and CLI utilities (`fd`, `ripgrep`) must be listed in `extraPackages` inside `config/default.nix`.
   - Language servers should be enabled in `config/lsp/lsp.nix`. If a custom package is required, specify `package = pkgs.<server-package>;`.

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
  - `feat: ...` or `feat(<scope>): ...` (e.g., `feat(lsp): add elixirls configuration`)
  - `fix: ...` or `fix(<scope>): ...`
  - `chore: ...` or `chore(<scope>): ...`
- **Verification Requirement**: Always verify your changes before completing a task by running:
  1. `nix flake check --no-build`
  2. `nix build .`
  3. `./result/bin/nvim --headless -c "qa"`
