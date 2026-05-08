-- Костыль для совместимости Neovim 0.12 (исправляет ошибку ft_to_lang в превью)
if vim.treesitter.language and not vim.treesitter.language.ft_to_lang then
    vim.treesitter.language.ft_to_lang = function(ft)
        return vim.treesitter.get_lang(ft) or ft
    end
end

local telescope = require('telescope')

telescope.setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
    },
})

local builtin = require('telescope.builtin')

-- Бинды (теперь будут работать через Пробел, если он в начале init.lua)
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

