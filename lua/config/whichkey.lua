-- ~/.config/nvim/lua/config/whichkey.lua
--
-- Панель подсказок: имена категорий, иконки и структура групп.
-- Сами биндинги здесь НЕ объявляются — они живут в lua/config/keymaps.lua
-- (глобальные), lua/config/lsp.lua (LSP, буферные) и lua/config/nvimtree.lua
-- (клавиши внутри дерева, справка по ним — g? в окне дерева).

local wk = require("which-key")

vim.o.timeout = true
vim.o.timeoutlen = 300

wk.setup({
  -- modern: широкое окно снизу (width 0.9), пункты в колонки, рамка rounded.
  -- Секцию win намеренно не переопределяем — своя таблица win затирает
  -- геометрию preset (width/height/col/row), и окно перестаёт быть modern.
  preset = "modern",
  layout = { spacing = 4, align = "left" },
  -- группы поднимаются наверх списка, внутри группы — по алфавиту
  sort = { "group", "alphanum", "local", "order", "mod" },
  expand = 0, -- группы не раскрывать заранее: показываем категории, а не всё сразу
  -- биндинги без описания в панель не попадают
  filter = function(mapping)
    return mapping.desc ~= nil and mapping.desc ~= ""
  end,
  plugins = {
    spelling = { enabled = true, suggestions = 20 },
  },
})

-- ============================================================================
-- Категории верхнего уровня
-- ============================================================================

wk.add({
  { "<leader>f", group = "Поиск", icon = { icon = "", color = "blue" } },
  { "<leader>b", group = "Буферы", icon = { icon = "", color = "cyan" } },
  { "<leader>t", group = "Табы", icon = { icon = "", color = "azure" } },
  { "<leader>c", group = "Код", icon = { icon = "", color = "green" } },
  { "<leader>g", group = "Git", icon = { icon = "", color = "orange" } },
  { "<leader>d", group = "Отладка", icon = { icon = "", color = "red" } },
  { "<leader>v", group = "Python", icon = { icon = "", color = "yellow" } },
  { "<leader>w", group = "Окна", icon = { icon = "", color = "purple" } },
  { "<leader>u", group = "Вид", icon = { icon = "", color = "grey" } },
  { "<leader>q", group = "Выход", icon = { icon = "", color = "red" } },

  -- Подгруппы
  { "<leader>gc", group = "Конфликты", icon = { icon = "", color = "orange" } },
  { "<leader>ts", group = "Сортировка", icon = { icon = "", color = "azure" } },

  -- Одиночные клавиши верхнего уровня
  { "<leader>e", icon = { icon = "", color = "yellow" } },
  { "<leader>?", icon = { icon = "", color = "cyan" } },
  { "<leader><leader>", icon = { icon = "", color = "cyan" } },

  -- Переходы по коду остаются на vim-стандартном g
  { "g", group = "Переход" },
})

-- ============================================================================
-- Быстрый переход к табам: рабочие, но скрытые
--
-- <leader>1..9 объявлены в keymaps.lua. Без hidden = true они занимали бы
-- девять строк верхнего уровня — именно из-за них панель была нечитаемой.
-- ============================================================================

for i = 1, 9 do
  wk.add({ { "<leader>" .. tostring(i), hidden = true } })
end
