-- ~/.config/nvim/lua/config/treesitter.lua
--#local ok, configs = pcall(require, "nvim-treesitter.configs")
-- if not ok then
--   vim.notify("Treesitter not loaded yet, run :Lazy sync and restart", vim.log.levels.WARN)
--   return
-- end

-- ~/.config/nvim/lua/config/treesitter.lua
require("nvim-treesitter").setup({
  ensure_installed = { "lua", "vim", "vimdoc", "python" },
  highlight = { enable = true },
  indent = { enable = true },
})