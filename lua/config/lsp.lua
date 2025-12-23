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

-- новый API: vim.lsp.config
local pyright = vim.lsp.config["pyright"] or vim.lsp._config("pyright", {})

vim.lsp.start_client(vim.tbl_deep_extend("force", pyright, {
  capabilities = capabilities,
  name = "pyright",
}))

-- ключевые биндинги
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)