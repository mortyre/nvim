-- Конфигурация nvim-tree для открытия файлов в новых вкладках
local api = require("nvim-tree.api")

-- Кастомная функция on_attach для настройки keymaps
local function my_on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Стандартные маппинги (включая 't' для открытия в новой вкладке)
  api.config.mappings.default_on_attach(bufnr)

  -- Дополнительные маппинги
  vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open in New Tab"))
  
  -- Можно также переназначить Enter для открытия в новой вкладке
  -- vim.keymap.set("n", "<CR>", api.node.open.tab, opts("Open in New Tab"))
  
  -- Или добавить альтернативные keymaps
  vim.keymap.set("n", "T", api.node.open.tab, opts("Open in New Tab"))
end

-- Настройка nvim-tree
require("nvim-tree").setup({
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  actions = {
    open_file = {
      -- Не закрывать nvim-tree после открытия файла
      quit_on_open = false,
      window_picker = {
        enable = true,
      },
    },
  },
  on_attach = my_on_attach,
})

-- Keymaps для nvim-tree
vim.keymap.set("n", "<leader>fe", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>fE", ":NvimTreeFindFile<CR>", { desc = "Find current file in explorer" })

-- Дополнительная keymap для быстрого открытия в новой вкладке
vim.keymap.set("n", "<leader>ft", function()
  -- Открыть nvim-tree
  api.tree.toggle()
  -- После открытия можно использовать 't' для открытия файла в новой вкладке
end, { desc = "Open file explorer for new tab" })

print("nvim-tree configured for opening files in new tabs!")