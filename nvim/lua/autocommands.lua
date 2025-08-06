-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = '*.go',
--   callback = function()
--     vim.lsp.buf.code_action({
--       apply = true,
--       filter = function(action)
--         return action.title:match('Convert to range loop')  -- Фильтр по нужным code action
--       end,
--     })
--   end,
-- })

--No highlight search after searching
vim.api.nvim_create_autocmd("CmdlineLeave", {
    pattern = "/,?",
    callback = function()
        vim.schedule(function()
            vim.cmd("nohlsearch")
        end)
    end,
})

-- Run gofmt + goimports on save

local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})
