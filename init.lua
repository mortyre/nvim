-- ~/.config/nvim/init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Установка лидера (пробел) - ДО загрузки плагинов
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins")

vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Keymaps для управления вкладками и буферами
-- Навигация по вкладкам
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "Close other tabs" })
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>", { desc = "Previous tab" })

-- Навигация по буферам (bufferline)
vim.keymap.set("n", "<leader>bpk", ":BufferLinePick<CR>", { desc = "Pick buffer" })
vim.keymap.set("n", "<leader>bpc", ":BufferLinePickClose<CR>", { desc = "Pick buffer to close" })
vim.keymap.set("n", "<leader>bcl", ":BufferLineCloseLeft<CR>", { desc = "Close buffers to the left" })
vim.keymap.set("n", "<leader>bcr", ":BufferLineCloseRight<CR>", { desc = "Close buffers to the right" })
vim.keymap.set("n", "<leader>bco", ":BufferLineCloseOthers<CR>", { desc = "Close other buffers" })

-- Перемещение буферов
vim.keymap.set("n", "<leader>bmn", ":BufferLineMoveNext<CR>", { desc = "Move buffer next" })
vim.keymap.set("n", "<leader>bmp", ":BufferLineMovePrev<CR>", { desc = "Move buffer previous" })

-- Сортировка буферов
vim.keymap.set("n", "<leader>bsn", ":BufferLineSortByTabs<CR>", { desc = "Sort by tabs" })
vim.keymap.set("n", "<leader>bsd", ":BufferLineSortByDirectory<CR>", { desc = "Sort by directory" })
vim.keymap.set("n", "<leader>bsl", ":BufferLineSortByLanguage<CR>", { desc = "Sort by language" })

-- Быстрая навигация по буферам
for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, function()
    require("bufferline").go_to_buffer(i, true)
  end, { desc = "Go to buffer " .. i })
end

-- Дополнительные keymaps для удобства
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bP", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bf", ":bfirst<CR>", { desc = "First buffer" })
vim.keymap.set("n", "<leader>bl", ":blast<CR>", { desc = "Last buffer" })

-- Переключение между последними буферами
vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Toggle last buffer" })
vim.opt.mouse = "a"
vim.keymap.set("v", "<LeftRelease>", '"+ygv', { noremap = true, silent = true })
vim.keymap.set("v", "<2-LeftRelease>", '"+ygv', { noremap = true, silent = true })
vim.opt.clipboard = {''}

-- Тестовая keymap для проверки лидера
vim.keymap.set("n", "<leader>test", function()
  print("✓ Лидер работает! Тестовая команда выполнена.")
end, { desc = "Test leader key" })

