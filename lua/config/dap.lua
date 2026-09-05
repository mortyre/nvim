-- ~/.config/nvim/lua/config/dap.lua
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


-- Биндинги <leader>d* и F5/F10/F11/F12 — в lua/config/keymaps.lua
