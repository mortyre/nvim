-- ~/.config/nvim/lua/config/lsp.lua
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "pyright" },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- Новый API (Nvim 0.11+). Базовый конфиг pyright приходит из nvim-lspconfig
-- (его lsp/pyright.lua), здесь мы только дополняем его своими capabilities.
-- vim.lsp.enable сам навешивает FileType-автокоманду, поэтому сервер
-- поднимается на python-буфере, а не при каждом старте nvim, как было
-- с прямым вызовом vim.lsp.start_client() (убран в Nvim 0.13).
vim.lsp.config("pyright", {
  capabilities = capabilities,
})
vim.lsp.enable("pyright")

-- ключевые биндинги — только в тех буферах, куда прикрепился LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
})
