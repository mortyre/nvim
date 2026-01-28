-- Оптимизированная конфигурация nvim-tree
-- Performance improvements:
-- - Debouncing для частых событий
-- - Ранние выходы из функций
-- - Кэширование состояния
-- - string.find() вместо regex match()
-- - Счетчики вместо массивов
-- - Уменьшенные debounce delays

local api = require("nvim-tree.api")

-- Кастомная функция on_attach для настройки keymaps
local function my_on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  -- Дополнительные keymaps
  vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "T", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
  vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
  vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
  vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
  vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse All"))
  vim.keymap.set("n", "/", api.live_filter.start, opts("Filter"))
  vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
  vim.keymap.set("n", "bt", api.marks.bulk.trash, opts("Trash Bookmarked"))
  vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
end

-- Настройка nvim-tree с оптимизациями производительности
require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,

  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = {},
  },

  view = {
    width = 35,
    side = "left",
    number = false,
    relativenumber = false,
    signcolumn = "yes",
  },

  renderer = {
    group_empty = true,
    full_name = false,
    highlight_git = true,
    highlight_opened_files = "name",
    highlight_modified = "name",
    root_folder_label = ":~:s?$?/..?",
    indent_width = 2,
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      modified_placement = "after",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "󰆤",
        modified = "●",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },

  filters = {
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    custom = { "^.git$" },
    exclude = {},
  },

  -- Git оптимизация: уменьшен таймаут, отключены проверки для директорий
  git = {
    enable = true,
    ignore = true, -- Ускорение: игнорируем gitignore файлы
    show_on_dirs = false, -- Ускорение: отключаем для директорий
    show_on_open_dirs = false,
    timeout = 200, -- Уменьшен с 400ms до 200ms
  },

  -- Диагностика оптимизация: увеличен debounce, отключены проверки для директорий
  diagnostics = {
    enable = true,
    show_on_dirs = false, -- Ускорение: отключаем для директорий
    show_on_open_dirs = false,
    debounce_delay = 150, -- Увеличен с 50ms до 150ms
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },

  modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },

  tab = {
    sync = {
      open = true,
      close = true,
      ignore = {},
    },
  },

  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = { ".git", "target", "build", "node_modules" },
    },
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "rounded",
        style = "minimal",
      },
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        picker = "default",
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },

  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },

  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },

  notify = {
    threshold = vim.log.levels.INFO,
  },

  on_attach = my_on_attach,
})

-- Глобальные keymaps
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>fe", ":NvimTreeToggle<CR>", { desc = "Toggle explorer" })
vim.keymap.set("n", "<leader>ff", ":NvimTreeFindFile<CR>", { desc = "Find file in explorer" })
vim.keymap.set("n", "<leader>fc", ":NvimTreeCollapse<CR>", { desc = "Collapse explorer" })
vim.keymap.set("n", "<leader>fr", ":NvimTreeRefresh<CR>", { desc = "Refresh explorer" })
vim.keymap.set("n", "<leader>fh", function()
  api.tree.toggle_help()
end, { desc = "Show explorer help" })

-- ============================================================================
-- ОПТИМИЗИРОВАННЫЕ АВТОКОМАНДЫ
-- ============================================================================

local nvim_tree_group = vim.api.nvim_create_augroup("NvimTreeAutoOpen", { clear = true })

-- Кэш состояния для оптимизации
local nvim_tree_state = {
  is_open = false,
  last_tab_check = 0
}

-- 1. TabEnter: оптимизирован с кэшированием и throttling
vim.api.nvim_create_autocmd("TabEnter", {
  group = nvim_tree_group,
  callback = function()
    -- Throttling: не проверяем чаще раза в 100ms
    local now = vim.loop.hrtime()
    if now - nvim_tree_state.last_tab_check < 100000000 then
      return
    end
    nvim_tree_state.last_tab_check = now

    local current_tab_wins = vim.api.nvim_tabpage_list_wins(0)

    -- Один проход: проверяем наличие nvim-tree в текущей вкладке
    for _, win in ipairs(current_tab_wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
      if bufname:find("NvimTree_", 1, true) then -- find быстрее match
        return -- nvim-tree уже есть
      end
    end

    -- Если кэш говорит что nvim-tree открыт, открываем его
    if nvim_tree_state.is_open then
      vim.cmd("NvimTreeOpen")
    else
      -- Проверяем, открыт ли вообще nvim-tree
      local all_wins = vim.api.nvim_list_wins()
      for _, w in ipairs(all_wins) do
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
        if bufname:find("NvimTree_", 1, true) then
          nvim_tree_state.is_open = true
          vim.cmd("NvimTreeOpen")
          return
        end
      end
    end
  end,
  desc = "Auto-open nvim-tree in new tabs (optimized)"
})

-- Обновление кэша при открытии nvim-tree
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = nvim_tree_group,
  pattern = "NvimTree_*",
  callback = function()
    nvim_tree_state.is_open = true
  end
})

-- Обновление кэша при закрытии nvim-tree
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = nvim_tree_group,
  pattern = "NvimTree_*",
  callback = function()
    -- Быстрая проверка: остались ли окна nvim-tree
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:find("NvimTree_", 1, true) then
        return -- Еще есть окна
      end
    end
    nvim_tree_state.is_open = false
  end
})

-- 2. QuitPre: оптимизирован со счетчиками вместо массивов
vim.api.nvim_create_autocmd("QuitPre", {
  group = nvim_tree_group,
  callback = function()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    local tree_win_count = 0
    local floating_win_count = 0
    local normal_win_count = 0

    -- Один проход с счетчиками (эффективнее массивов)
    for _, w in ipairs(wins) do
      local config = vim.api.nvim_win_get_config(w)

      if config.relative ~= '' then
        floating_win_count = floating_win_count + 1
      else
        local buf = vim.api.nvim_win_get_buf(w)
        local bufname = vim.api.nvim_buf_get_name(buf)

        if bufname:find("NvimTree_", 1, true) then
          tree_win_count = tree_win_count + 1
        else
          normal_win_count = normal_win_count + 1
        end
      end
    end

    -- Закрываем nvim-tree только если нужно
    if normal_win_count == 1 then
      for _, w in ipairs(wins) do
        local config = vim.api.nvim_win_get_config(w)
        if config.relative == '' then
          local buf = vim.api.nvim_win_get_buf(w)
          local bufname = vim.api.nvim_buf_get_name(buf)
          if bufname:find("NvimTree_", 1, true) then
            vim.api.nvim_win_close(w, true)
          end
        end
      end
    end
  end,
  desc = "Auto-close nvim-tree when last window (optimized)"
})

-- 3. BufEnter: оптимизирован с debouncing и ранними выходами
local tab_close_timer = nil

vim.api.nvim_create_autocmd("BufEnter", {
  group = nvim_tree_group,
  callback = function()
    -- Debouncing: отменяем предыдущий таймер
    if tab_close_timer then
      vim.fn.timer_stop(tab_close_timer)
    end

    -- Новый таймер с задержкой 50ms
    tab_close_timer = vim.fn.timer_start(50, function()
      -- Ранний выход: если последняя вкладка, не проверяем
      if vim.fn.tabpagenr("$") == 1 then
        return
      end

      local wins = vim.api.nvim_tabpage_list_wins(0)

      -- Ранний выход: если больше 1 окна, есть обычные окна
      if #wins > 1 then
        return
      end

      -- Проверяем единственное окно
      if #wins == 1 and vim.api.nvim_win_is_valid(wins[1]) then
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(wins[1]))
        if bufname:find("NvimTree_", 1, true) then
          vim.cmd("tabclose")
        end
      end
    end)
  end,
  desc = "Auto-close tab if no normal windows (optimized)"
})
