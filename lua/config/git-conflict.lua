-- ~/.config/nvim/lua/config/git-conflict.lua
local git_conflict = require("git-conflict")

git_conflict.setup({
  default_mappings = true,
  default_commands = true,
  disable_diagnostics = false,
  highlights = {
    incoming = "DiffAdd",
    current = "DiffText",
  },
  debug = false,
})

-- Биндинги <leader>gc* / <leader>gn / <leader>gp — в lua/config/keymaps.lua
