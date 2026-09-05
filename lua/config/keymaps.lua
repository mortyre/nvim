-- ~/.config/nvim/lua/config/keymaps.lua
--
-- Единственный источник ГЛОБАЛЬНЫХ горячих клавиш.
-- Буферные биндинги живут отдельно и здесь их быть не должно:
--   * LSP-действия  -> lua/config/lsp.lua, автокоманда LspAttach
--   * клавиши дерева -> lua/config/nvimtree.lua, my_on_attach
--
-- Категории верхнего уровня (их имена и иконки — в lua/config/whichkey.lua):
--   f Поиск · b Буферы · t Табы · c Код · g Git · d Отладка
--   v Python · w Окна · u Вид · q Выход · e Проводник · ? Все клавиши
--
-- Плагины требуются лениво, внутри функций: этот файл выполняется сразу
-- после lazy.setup(), когда сами плагины ещё могут быть не загружены.

local map = vim.keymap.set

---Обёртка для ленивого вызова функции плагина.
---@param module string имя модуля, например "telescope.builtin"
---@param fn string имя функции в модуле
---@param ... any аргументы, передаваемые в функцию
local function lazy_call(module, fn, ...)
  local args = { ... }
  return function()
    require(module)[fn](unpack(args))
  end
end

-- ============================================================================
-- ПОИСК (Telescope) — <leader>f
-- ============================================================================

local tb = "telescope.builtin"

map("n", "<leader>ff", lazy_call(tb, "find_files"), { desc = "Файлы" })
map("n", "<leader>fg", lazy_call(tb, "live_grep"), { desc = "Grep по проекту" })
map("n", "<leader>fw", lazy_call(tb, "grep_string"), { desc = "Слово под курсором" })
map("n", "<leader>fb", lazy_call(tb, "buffers"), { desc = "Открытые буферы" })
map("n", "<leader>fo", lazy_call(tb, "oldfiles"), { desc = "Недавние файлы" })
map("n", "<leader>fl", lazy_call(tb, "current_buffer_fuzzy_find"), { desc = "Строки в файле" })
map("n", "<leader>fk", lazy_call(tb, "keymaps"), { desc = "Горячие клавиши" })
map("n", "<leader>fh", lazy_call(tb, "help_tags"), { desc = "Справка Vim" })
map("n", "<leader>fc", lazy_call(tb, "commands"), { desc = "Команды" })
map("n", "<leader>fd", lazy_call(tb, "diagnostics"), { desc = "Диагностика" })
map("n", "<leader>fs", lazy_call(tb, "lsp_document_symbols"), { desc = "Символы файла" })
map("n", "<leader>fr", lazy_call(tb, "resume"), { desc = "Повторить поиск" })

-- ============================================================================
-- ПРОВОДНИК — <leader>e (одиночная клавиша, не группа)
-- ============================================================================

map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Проводник" })

-- ============================================================================
-- БУФЕРЫ — <leader>b
-- ============================================================================

map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Закрыть буфер" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Следующий" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Предыдущий" })
map("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "Первый" })
map("n", "<leader>bl", "<cmd>blast<cr>", { desc = "Последний" })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Закрыть все, кроме текущего" })

map("n", "<leader><leader>", "<C-^>", { desc = "Предыдущий буфер" })

-- ============================================================================
-- ТАБЫ — <leader>t
--
-- bufferline настроен в mode = "tabs" (см. plugins.lua), поэтому
-- BufferLine* команды и go_to_buffer работают с ТАБАМИ, а не с буферами.
-- ============================================================================

map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Новый таб" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Закрыть таб" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Закрыть остальные" })
map("n", "<leader>tp", "<cmd>BufferLinePick<cr>", { desc = "Выбрать" })
map("n", "<leader>tx", "<cmd>BufferLinePickClose<cr>", { desc = "Выбрать и закрыть" })
map("n", "<leader>th", "<cmd>BufferLineMovePrev<cr>", { desc = "Сдвинуть влево" })
map("n", "<leader>tl", "<cmd>BufferLineMoveNext<cr>", { desc = "Сдвинуть вправо" })

map("n", "<leader>tst", "<cmd>BufferLineSortByTabs<cr>", { desc = "По табам" })
map("n", "<leader>tsd", "<cmd>BufferLineSortByDirectory<cr>", { desc = "По каталогу" })
map("n", "<leader>tsl", "<cmd>BufferLineSortByLanguage<cr>", { desc = "По языку" })

map("n", "<Tab>", "<cmd>tabnext<cr>", { desc = "Следующий таб" })
map("n", "<S-Tab>", "<cmd>tabprevious<cr>", { desc = "Предыдущий таб" })

-- Быстрый переход к табу 1-9. Рабочие, но скрыты из панели подсказок
-- через hidden = true в whichkey.lua, иначе занимали бы 9 строк верхнего уровня.
for i = 1, 9 do
  map("n", "<leader>" .. i, function()
    require("bufferline").go_to_buffer(i, true)
  end, { desc = "Таб " .. i })
end

-- ============================================================================
-- GIT — <leader>g
--
-- Внимание: gc — это группа «Конфликты», поэтому навигация по конфликтам
-- вынесена на gn/gp. Раньше Choose none был на gcn и являлся префиксом
-- gcnx (Next conflict), из-за чего gcn всегда ждал timeoutlen.
-- ============================================================================

map("n", "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", { desc = "Взять наши" })
map("n", "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Взять их" })
map("n", "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Взять оба" })
map("n", "<leader>gcx", "<cmd>GitConflictChooseNone<cr>", { desc = "Не брать ничего" })
map("n", "<leader>gcl", "<cmd>GitConflictListQf<cr>", { desc = "Список в quickfix" })

map("n", "<leader>gn", "<cmd>GitConflictNextConflict<cr>", { desc = "Следующий конфликт" })
map("n", "<leader>gp", "<cmd>GitConflictPrevConflict<cr>", { desc = "Предыдущий конфликт" })

-- ============================================================================
-- ОТЛАДКА — <leader>d
-- ============================================================================

map("n", "<leader>db", lazy_call("dap", "toggle_breakpoint"), { desc = "Точка останова" })
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Условие точки останова: "))
end, { desc = "Условная точка" })
map("n", "<leader>dc", lazy_call("dap", "continue"), { desc = "Продолжить" })
map("n", "<leader>ds", lazy_call("dap", "step_over"), { desc = "Шаг через" })
map("n", "<leader>di", lazy_call("dap", "step_into"), { desc = "Шаг внутрь" })
map("n", "<leader>dO", lazy_call("dap", "step_out"), { desc = "Шаг наружу" })
map("n", "<leader>dr", function()
  require("dap").repl.toggle()
end, { desc = "REPL" })
map("n", "<leader>dt", lazy_call("dap", "terminate"), { desc = "Остановить сессию" })
map("n", "<leader>dm", lazy_call("dap-python", "test_method"), { desc = "Отладить тест-метод" })
map("n", "<leader>dC", lazy_call("dap-python", "test_class"), { desc = "Отладить тест-класс" })

-- F-клавиши как дубли для отладочной сессии (теперь с описаниями)
map("n", "<F5>", lazy_call("dap", "continue"), { desc = "Отладка: продолжить" })
map("n", "<F10>", lazy_call("dap", "step_over"), { desc = "Отладка: шаг через" })
map("n", "<F11>", lazy_call("dap", "step_into"), { desc = "Отладка: шаг внутрь" })
map("n", "<F12>", lazy_call("dap", "step_out"), { desc = "Отладка: шаг наружу" })

-- ============================================================================
-- PYTHON — <leader>v
-- ============================================================================

map("n", "<leader>ve", lazy_call("swenv.api", "pick_venv"), { desc = "Выбрать venv" })
map("n", "<leader>vi", function()
  local venv = require("swenv.api").get_current_venv()
  vim.notify(venv and (venv.name .. "  —  " .. venv.path) or "venv не выбран")
end, { desc = "Текущий venv" })

-- ============================================================================
-- ОКНА — <leader>w
-- ============================================================================

map("n", "<leader>ws", "<cmd>split<cr>", { desc = "Разделить горизонтально" })
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Разделить вертикально" })
map("n", "<leader>wc", "<cmd>close<cr>", { desc = "Закрыть окно" })
map("n", "<leader>wo", "<cmd>only<cr>", { desc = "Закрыть остальные" })
map("n", "<leader>wh", "<C-w>h", { desc = "Влево" })
map("n", "<leader>wj", "<C-w>j", { desc = "Вниз" })
map("n", "<leader>wk", "<C-w>k", { desc = "Вверх" })
map("n", "<leader>wl", "<C-w>l", { desc = "Вправо" })
map("n", "<leader>w=", "<C-w>=", { desc = "Выровнять размеры" })

-- ============================================================================
-- ВИД — <leader>u
-- ============================================================================

---Переключает булеву опцию и сообщает новое состояние.
---@param opt string имя опции
---@param label string человекочитаемое название
local function toggle_opt(opt, label)
  return function()
    vim.o[opt] = not vim.o[opt]
    vim.notify(label .. ": " .. (vim.o[opt] and "вкл" or "выкл"))
  end
end

map("n", "<leader>un", toggle_opt("number", "Номера строк"), { desc = "Номера строк" })
map("n", "<leader>ur", toggle_opt("relativenumber", "Относительные номера"), { desc = "Относительные номера" })
map("n", "<leader>uw", toggle_opt("wrap", "Перенос строк"), { desc = "Перенос строк" })
map("n", "<leader>us", toggle_opt("spell", "Орфография"), { desc = "Орфография" })
map("n", "<leader>ul", toggle_opt("list", "Невидимые символы"), { desc = "Невидимые символы" })
map("n", "<leader>ud", function()
  local on = vim.diagnostic.is_enabled()
  vim.diagnostic.enable(not on)
  vim.notify("Диагностика: " .. (on and "выкл" or "вкл"))
end, { desc = "Диагностика" })

-- ============================================================================
-- ВЫХОД — <leader>q
-- ============================================================================

map("n", "<leader>qq", "<cmd>quit<cr>", { desc = "Выйти" })
map("n", "<leader>qQ", "<cmd>quit!<cr>", { desc = "Выйти без сохранения" })
map("n", "<leader>qa", "<cmd>quitall<cr>", { desc = "Закрыть все и выйти" })

-- ============================================================================
-- ПОЛНЫЙ СПИСОК КЛАВИШ — <leader>?
-- ============================================================================

-- Прямой вызов API, а не :WhichKey: команда создаётся только внутри setup(),
-- а require подхватит плагин независимо от порядка загрузки.
map("n", "<leader>?", function()
  require("which-key").show({ mode = "n", keys = "" })
end, { desc = "Все клавиши" })

-- ============================================================================
-- VISUAL-РЕЖИМ
-- ============================================================================

map("v", "<leader>p", '"_dP', { desc = "Вставить, не теряя буфер обмена" })
map("v", "<leader>y", '"+y', { desc = "Копировать в системный буфер" })

-- Копирование выделения мышью в системный буфер обмена
map("v", "<LeftRelease>", '"+ygv', { desc = "Копировать в буфер обмена", noremap = true, silent = true })
map("v", "<2-LeftRelease>", '"+ygv', { desc = "Копировать в буфер обмена", noremap = true, silent = true })
