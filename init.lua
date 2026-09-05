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

-- Мышь и буфер обмена
vim.opt.mouse = "a"
vim.opt.clipboard = { "" }

-- Горячие клавиши и панель подсказок
require("config.keymaps")
