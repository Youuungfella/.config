local map = vim.keymap.set
local dap = require('dap')

vim.g.mapleader = " "
map("n", " ", "<Nop>", { silent = true, remap = false })
map('i', 'jk', '<Esc>', { noremap = true, silent = true })
--LSP bindings
map('n', 'gd', function()
  vim.lsp.buf.definition()
end, { buffer = bufnr, desc = 'Go to Definition' })

vim.api.nvim_set_keymap(
  'n',
  '<leader>re',
  '<cmd>lua vim.lsp.buf.rename()<CR>',
  { noremap = true, silent = true, desc = "Lsp rename" }
)

map('n', 'gdv', function()
  vim.cmd('vsplit')
  vim.lsp.buf.definition()
end, { noremap = true, silent = true, desc = "go definition new tab" })
map('n', 'gr', function ()
	vim.lsp.buf.references()
end, {buffer = bufnr, desc = 'Show references'})
vim.api.nvim_set_keymap(
  'n',
  '<leader>ca',
  '<cmd>lua vim.lsp.buf.code_action()<CR>',
  { noremap = true, silent = true, desc = "Code Action" }
)
--Go code runner
map('n','<leader>rr','<cmd>!go run %:p<CR>', { noremap = true, silent = true, desc = "Run current gofile" })
--Diagnostics keymaps
-- map('n','<leader>wn','<cmd>lua vim.diagnostic.goto_next()<CR>',{ noremap = true, silent = true, desc = "Go to next warning" })
-- map('n','<leader>wp','<cmd>lua vim.diagnostic.goto_prev()<CR>',{ noremap = true, silent = true, desc = "Go to prev warning" })
map('n', '<leader>ww', function()
  -- Открываем loclist
  vim.diagnostic.setloclist()

  -- Автокоманда, которая закроет loclist после выбора
  vim.api.nvim_create_autocmd('BufEnter', {
    once = true,  -- выполнится только один раз
    callback = function()
      -- Проверяем, что буфер в текущем окне - это НЕ loclist
      if vim.bo.filetype ~= 'qf' then
        vim.cmd('lclose')  -- закрываем loclist
      end
    end
  })
end)
--Explore binding
map('n','<leader>ex','<cmd>Ex<CR>', { noremap=true})
--Debug hotkeys
map('n', '<F5>', function() dap.continue() end)
map('n', '<F10>', function() dap.step_over() end)
map('n', '<F11>', function() dap.step_into() end)
map('n', '<F12>', function() dap.step_out() end)
map('n', '<leader>b', function() dap.toggle_breakpoint() end)
