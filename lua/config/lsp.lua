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

-- Буферные биндинги: вешаются только там, где прикрепился LSP.
-- Глобальные горячие клавиши — в lua/config/keymaps.lua.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local function opts(desc)
      return { buffer = ev.buf, desc = desc }
    end

    -- Переходы по коду: остаются на vim-стандартном g
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("К определению"))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Ссылки"))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("К реализации"))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Документация"))

    -- Категория «Код» — <leader>c
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts("Переименовать символ"))
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Действие с кодом"))
    vim.keymap.set("n", "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, opts("Форматировать"))
    vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts("Диагностика строки"))
    vim.keymap.set("n", "<leader>cs", function()
      require("telescope.builtin").lsp_document_symbols()
    end, opts("Символы документа"))
    vim.keymap.set("n", "<leader>ci", "<cmd>checkhealth vim.lsp<cr>", opts("Информация о LSP"))
  end,
})
