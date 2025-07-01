-- Показывать ошибки прямо в коде
vim.diagnostic.config({
  virtual_text = true,  -- или { prefix = "●", spacing = 2 }
  signs = true,        -- значки слева от строки (например, ❌)
  update_in_insert = false,  -- не обновлять при вводе текста (чтобы не мешать)
})
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = false   -- Использовать табы вместо пробелов
vim.opt.tabstop = 4        -- 1 таб = 4 пробела
vim.opt.shiftwidth = 4     -- Размер отступа = 4 пробела
vim.opt.softtabstop = 4    -- "Мягкие" табы (backspace будет удалять как таб)

