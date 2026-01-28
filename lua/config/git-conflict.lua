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

-- Кастомные keymaps для работы с конфликтами
vim.keymap.set("n", "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", { desc = "Choose ours in git conflict" })
vim.keymap.set("n", "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Choose theirs in git conflict" })
vim.keymap.set("n", "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Choose both in git conflict" })
vim.keymap.set("n", "<leader>gcn", "<cmd>GitConflictChooseNone<cr>", { desc = "Choose none in git conflict" })
vim.keymap.set("n", "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", { desc = "Go to previous git conflict" })
vim.keymap.set("n", "<leader>gcnx", "<cmd>GitConflictNextConflict<cr>", { desc = "Go to next git conflict" })
vim.keymap.set("n", "<leader>gcl", "<cmd>GitConflictListQf<cr>", { desc = "List all conflicts in quickfix" })