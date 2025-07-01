local lspconfig = require('lspconfig')
lspconfig.gopls.setup({
	settings = {
    gopls = {
      analyses = {
        loopvar = true,  -- Показывает предупреждения для "неидиоматических" циклов
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        rangeVariableTypes = true,  -- Подсказывает использовать `range` вместо C-style for
      },
    },
  },
 })
lspconfig.lua_ls.setup({})
lspconfig.pyright.setup({})
