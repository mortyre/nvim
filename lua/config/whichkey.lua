local wk = require("which-key")

-- Добавляем timeout настройки
vim.o.timeout = true
vim.o.timeoutlen = 300

-- ========== Регистрация групп и описаний ==========
wk.add({
  -- Главный leader
  { "<leader><leader>", desc = "Toggle last buffer" },
  { "<leader>e", desc = "Toggle file explorer" },

  -- ===== Буферы =====
  { "<leader>b", group = "buffers" },
  { "<leader>bd", desc = "Delete buffer" },
  { "<leader>bn", desc = "Next buffer" },
  { "<leader>bP", desc = "Previous buffer" },
  { "<leader>bf", desc = "First buffer" },
  { "<leader>bl", desc = "Last buffer" },

  -- Группа close
  { "<leader>bc", group = "close" },
  { "<leader>bcl", desc = "Close buffers left" },
  { "<leader>bcr", desc = "Close buffers right" },
  { "<leader>bco", desc = "Close other buffers" },

  -- Группа pick
  { "<leader>bp", group = "pick" },
  { "<leader>bpk", desc = "Pick buffer" },
  { "<leader>bpc", desc = "Pick buffer to close" },

  -- Группа move
  { "<leader>bm", group = "move" },
  { "<leader>bmn", desc = "Move buffer next" },
  { "<leader>bmp", desc = "Move buffer previous" },

  -- Группа sort
  { "<leader>bs", group = "sort" },
  { "<leader>bsn", desc = "Sort by tabs" },
  { "<leader>bsd", desc = "Sort by directory" },
  { "<leader>bsl", desc = "Sort by language" },

  -- Быстрый доступ к буферам 1-9
  { "<leader>1", desc = "Go to buffer 1" },
  { "<leader>2", desc = "Go to buffer 2" },
  { "<leader>3", desc = "Go to buffer 3" },
  { "<leader>4", desc = "Go to buffer 4" },
  { "<leader>5", desc = "Go to buffer 5" },
  { "<leader>6", desc = "Go to buffer 6" },
  { "<leader>7", desc = "Go to buffer 7" },
  { "<leader>8", desc = "Go to buffer 8" },
  { "<leader>9", desc = "Go to buffer 9" },

  -- ===== Файлы и поиск =====
  { "<leader>f", group = "files" },
  { "<leader>fe", desc = "Toggle explorer" },
  { "<leader>ff", desc = "Find file in explorer" },
  { "<leader>fc", desc = "Collapse explorer" },
  { "<leader>fr", desc = "Refresh explorer" },
  { "<leader>fh", desc = "Show explorer help" },

  -- ===== Табы =====
  { "<leader>t", group = "tabs" },
  { "<leader>tn", desc = "New tab" },
  { "<leader>tc", desc = "Close tab" },
  { "<leader>to", desc = "Close other tabs" },
  { "<Tab>", desc = "Next tab" },
  { "<S-Tab>", desc = "Previous tab" },

  -- ===== Debug =====
  { "<leader>d", group = "debug" },
  { "<leader>db", desc = "Toggle breakpoint" },
  { "<F5>", desc = "Continue (Debug)" },
  { "<F10>", desc = "Step over (Debug)" },
  { "<F11>", desc = "Step into (Debug)" },
  { "<F12>", desc = "Step out (Debug)" },

  -- ===== Python venv =====
  { "<leader>v", group = "venv" },
  { "<leader>ve", desc = "Pick Python venv" },

  -- ===== LSP =====
  { "<leader>r", group = "refactor" },
  { "<leader>rn", desc = "Rename symbol" },

  { "g", group = "goto" },
  { "gd", desc = "Go to definition" },
  { "gr", desc = "Find references" },
  { "K", desc = "Show documentation (hover)" },

  -- ===== Test =====
  { "<leader>test", desc = "Test leader key" },
})

-- Регистрация для визуального режима
wk.add({
  { "<leader>p", desc = "Paste without replacing", mode = "v" },
  { "<LeftRelease>", desc = "Copy to clipboard", mode = "v" },
  { "<2-LeftRelease>", desc = "Copy to clipboard", mode = "v" },
})

-- ========== nvim-tree внутренние hotkeys ==========
-- Эти клавиши работают только внутри окна nvim-tree.
-- Полный список: нажмите g? внутри nvim-tree
--
-- НАВИГАЦИЯ И ОТКРЫТИЕ:
--   <CR>, o         - Открыть файл/папку
--   <2-LeftMouse>   - Открыть файл/папку
--   v               - Открыть в вертикальном сплите
--   s               - Открыть в горизонтальном сплите
--   t, <C-t>, T     - Открыть в новой вкладке
--   <Tab>           - Превью файла
--   <C-e>           - Открыть, заменив nvim-tree буфер
--
-- ФАЙЛОВЫЕ ОПЕРАЦИИ:
--   a               - Создать файл/папку (/ в конце для папки)
--   d               - Удалить
--   D               - Удалить в корзину
--   r               - Переименовать
--   <C-r>           - Переименовать (без имени файла)
--   x               - Вырезать
--   c               - Копировать
--   p               - Вставить
--   y               - Скопировать имя файла
--   Y               - Скопировать относительный путь
--   gy              - Скопировать абсолютный путь
--
-- НАВИГАЦИЯ ПО ДЕРЕВУ:
--   P               - Родительская папка
--   K               - Первый элемент уровня
--   J               - Последний элемент уровня
--   -               - Подняться на уровень вверх
--   <BS>            - Закрыть папку
--   ]e, [e          - Следующая/предыдущая диагностика
--   ]c, [c          - Следующий/предыдущий git файл
--
-- РАЗВЕРНУТЬ/СВЕРНУТЬ:
--   O               - Открыть без window picker
--   E               - Развернуть все папки
--   W               - Свернуть все папки
--
-- ПОИСК И ФИЛЬТРАЦИЯ:
--   f, /            - Начать живой фильтр
--   F               - Очистить фильтр
--   S               - Поиск узла
--
-- ОТОБРАЖЕНИЕ:
--   H               - Показать/скрыть скрытые файлы
--   I               - Показать/скрыть gitignored
--   U               - Показать/скрыть кастомный фильтр
--   B               - Показать/скрыть no-buffer файлы
--   R               - Обновить дерево
--   g?              - Показать полную справку
--
-- ИНФОРМАЦИЯ:
--   <C-k>           - Информация о файле (popup)
--   g.              - Toggle git clean filter
--   gx              - Открыть с системным приложением
--
-- УПРАВЛЕНИЕ:
--   q               - Закрыть nvim-tree
--   C               - Сменить корень на выбранную папку
--   m               - Переключить закладку
--   bd              - Удалить закладки (bulk)
--   bt              - Удалить закладки в корзину (bulk)
--   bmv             - Переместить закладки (bulk)
