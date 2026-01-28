# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a personal Neovim configuration using **lazy.nvim** as the plugin manager. The configuration is modular:

- `init.lua` - Entry point that:
  - Bootstraps lazy.nvim if not present
  - Sets leader key to space (BEFORE loading plugins - critical ordering)
  - Loads plugins via `require("lazy").setup("plugins")`
  - Defines global vim options and extensive keymaps

- `lua/plugins.lua` - Returns a Lua table with all plugin specifications for lazy.nvim
  - Each plugin can have `dependencies` and `config` functions
  - Config functions typically call `require("config.X")` for modular setup

- `lua/config/` - Individual plugin configuration modules:
  - `lsp.lua` - Mason + LSP setup (currently Pyright for Python)
  - `cmp.lua` - nvim-cmp autocompletion
  - `dap.lua` - Debug Adapter Protocol (Python debugging)
  - `treesitter.lua` - Syntax highlighting
  - `nvimtree.lua` - File explorer
  - `whichkey.lua` - Keymap hints
  - `git-conflict.lua` - Git conflict resolution

## Key Technical Details

### Plugin Management
- Uses lazy.nvim with lazy loading (`event = "VeryLazy"`, etc.)
- To add plugins: edit `lua/plugins.lua` and add to the returned table
- Create corresponding config file in `lua/config/` if complex setup needed
- Plugin specs use `dependencies` to declare load order

### LSP Configuration
- Uses Mason for LSP server installation (`:Mason` to manage)
- LSP servers configured in `lua/config/lsp.lua`
- Currently uses **new Neovim LSP API**: `vim.lsp.config` and `vim.lsp.start_client`
- Capabilities extended with cmp_nvim_lsp for autocompletion integration

### Python Development Focus
- Pyright LSP server auto-installed via Mason
- DAP (debugpy) for debugging, also managed by Mason
- swenv.nvim for virtual environment switching (`<leader>ve`)
- Debug keymaps: F5 (continue), F10 (step over), F11 (step into), F12 (step out)

### Buffer/Tab Navigation
- Bufferline configured in "tabs" mode with extensive custom keymaps in `init.lua`
- Space is the leader key
- All buffer keymaps start with `<leader>b` prefix
- All tab keymaps start with `<leader>t` prefix
- `<leader>1` through `<leader>9` jump to specific buffers
- See which-key popup (just press space) for all available keymaps

## Common Commands

### Plugin Management
```vim
:Lazy           " Open lazy.nvim UI
:Lazy sync      " Install/update/clean plugins
:Lazy update    " Update plugins
:Lazy clean     " Remove unused plugins
```

### LSP & Development Tools
```vim
:Mason          " Manage LSP servers, DAP adapters, linters
:LspInfo        " Show LSP server status
:LspRestart     " Restart LSP servers
```

### File Navigation
```vim
:NvimTreeToggle     " Toggle file explorer
:NvimTreeFindFile   " Find current file in explorer
:NvimTreeCollapse   " Collapse all folders
:NvimTreeRefresh    " Refresh file tree
:Telescope          " Fuzzy finder (configured but keymaps not shown in provided files)

" nvim-tree keymaps (global):
<leader>e     " Toggle file explorer (quick access)
<leader>fe    " Toggle file explorer
<leader>ff    " Find current file in explorer
<leader>fc    " Collapse explorer
<leader>fr    " Refresh explorer
<leader>fh    " Show explorer help

" nvim-tree keymaps (inside tree window):
" Navigation:
  <CR>, o           " Open file/folder
  v                 " Open in vertical split
  s                 " Open in horizontal split
  t, <C-t>          " Open in new tab
  <Tab>             " Preview file

" File operations:
  a                 " Create file/folder (end with / for folder)
  d                 " Delete
  r                 " Rename
  x                 " Cut
  c                 " Copy
  p                 " Paste
  y                 " Copy filename
  Y                 " Copy relative path
  gy                " Copy absolute path

" Tree navigation:
  P                 " Parent directory
  -                 " Up one level
  E                 " Expand all
  W                 " Collapse all

" Display:
  H                 " Toggle hidden files
  I                 " Toggle git ignored files
  R                 " Refresh tree
  f, /              " Start live filter
  F                 " Clear filter
  g?                " Show all keybindings help
```

### Testing Modifications
After editing configuration files:
1. Save the file
2. Restart Neovim or `:source %` (for some files)
3. For plugin changes: `:Lazy sync`
4. For LSP changes: `:LspRestart`

## Configuration Patterns

### Adding a New Plugin
1. Add entry to `lua/plugins.lua` table:
   ```lua
   {
     "author/plugin-name",
     dependencies = { "dep1", "dep2" },
     config = function()
       require("config.plugin-name")
     end,
   }
   ```
2. Create `lua/config/plugin-name.lua` with setup code
3. Run `:Lazy sync`

### Adding New Keymaps
- Add to `init.lua` (after plugin loading) for global keymaps
- Add inside plugin's `config` function in `plugins.lua` for plugin-specific keymaps
- Always include `desc` field for which-key integration

### LSP Server Addition
1. Add server name to `ensure_installed` in `lua/config/lsp.lua`
2. Configure server using the new `vim.lsp.config` API pattern shown for Pyright
3. Run `:Mason` to verify installation

## Important Notes

- The leader key MUST be set before lazy.nvim loads plugins (currently done correctly in `init.lua:16-17`)
- This config uses Neovim's new LSP API (`vim.lsp.config`, `vim.lsp.start_client`) rather than lspconfig's `setup()` pattern
- **which-key integration**: Press `<Space>` (leader key) and wait ~300ms to see all available keybindings in a popup menu
- **nvim-tree behavior**:
  - Configured to stay open when opening files (including in new tabs)
  - Automatically syncs across all tabs (opens in new tabs if already open)
  - Press `g?` inside the tree window to see all available commands
  - Opening a file with `t` or `<C-t>` opens it in a new tab while keeping nvim-tree visible
- Some files contain Russian comments - the author's native language
