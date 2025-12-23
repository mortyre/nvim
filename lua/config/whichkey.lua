local wk = require("which-key")

-- Настройка which-key (основная конфигурация уже установлена в plugins.lua)
-- Здесь только регистрация mappings

-- Добавляем timeout настройки
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Регистрация префиксов для лучшей организации
-- local mappings = {
--     { "<leader>b", group = "buffer" },
--     { "<leader>bP", desc = "Previous buffer" },
--     { "<leader>bc", group = "close" },
--     { "<leader>bcl", desc = "Close buffers left" },
--     { "<leader>bco", desc = "Close other buffers" },
--     { "<leader>bcr", desc = "Close buffers right" },
--     { "<leader>bd", desc = "Delete buffer" },
--     { "<leader>bf", desc = "First buffer" },
--     { "<leader>bk", desc = "Buffer Keymaps (which-key)" },
--     { "<leader>bl", desc = "Last buffer" },
--     { "<leader>bm", group = "move" },
--     { "<leader>bmn", desc = "Move buffer next" },
--     { "<leader>bmp", desc = "Move buffer previous" },
--     { "<leader>bn", desc = "Next buffer" },
--     { "<leader>bp", group = "pick" },
--     { "<leader>bpc", desc = "Pick buffer to close" },
--     { "<leader>bpk", desc = "Pick buffer" },
--     { "<leader>bs", group = "sort" },
--     { "<leader>bsd", desc = "Sort by directory" },
--     { "<leader>bsl", desc = "Sort by language" },
--     { "<leader>bsn", desc = "Sort by tabs" },
--     { "<leader>d", group = "debug" },
--     { "<leader>db", desc = "Toggle breakpoint" },
--     { "<leader>f", group = "file/find" },
--     { "<leader>fE", desc = "Find current file in explorer" },
--     { "<leader>fb", desc = "Buffers" },
--     { "<leader>fe", desc = "Toggle file explorer" },
--     { "<leader>ff", desc = "Find files" },
--     { "<leader>fg", desc = "Live grep" },
--     { "<leader>fh", desc = "Help tags" },
--     { "<leader>r", group = "rename" },
--     { "<leader>rn", desc = "Rename symbol" },
--     { "<leader>t", group = "tabs" },
--     { "<leader>tc", desc = "Close tab" },
--     { "<leader>test", desc = "Test leader key" },
--     { "<leader>tn", desc = "New tab" },
--     { "<leader>to", desc = "Close other tabs" },
--     { "<leader>v", group = "venv" },
--     { "<leader>ve", desc = "Pick Python venv" },
--     { "K", desc = "Show documentation" },
--     { "[d", desc = "Previous diagnostic" },
--     { "]d", desc = "Next diagnostic" },
--     { "g", group = "goto" },
--     { "gd", desc = "Go to definition" },
--     { "gr", desc = "Find references" },
-- }

-- Регистрируем mappings
-- wk.register(mappings)

-- Дополнительные настройки для разных режимов
wk.register({
  ["<leader>"] = {
    p = "Paste without replacing (visual mode)",
  },
}, { mode = "v" })

-- Настройки для оператора pending mode
wk.register({
  ["<leader>"] = {
    y = "Yank to system clipboard",
    Y = "Yank line to system clipboard",
    d = "Delete to black hole",
  },
}, { mode = "n", prefix = "" })

print("which-key.nvim configured successfully!")
