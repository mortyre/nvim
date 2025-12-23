-- ~/.config/nvim/lua/config/dap.lua
local dap = require("dap")
local dap_python = require("dap-python")
-- local mason_registry = require("mason-registry")

-- нужно установить debugpy через Mason: :Mason, выбрать debugpy, Install
--local debugpy = mason_registry.get_package("debugpy")
--local path = debugpy:get_install_path()

--local python_path = path .. "/venv/bin/python"

require("mason-nvim-dap").setup({
  ensure_installed = { "python" },  -- mason-nvim-dap знает, что "python" = debugpy
  automatic_installation = true,
})

dap_python.setup()


vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })