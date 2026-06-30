require("catppuccin").setup({
	flavour = "macchiato", -- latte, frappe, macchiato, mocha
	background = {      -- :h background
		light = "macchiato",
		dark = "macchiato",
	},
	transparent_background = true, -- disables setting the background color.
	show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	term_colors = true,         -- sets terminal colors (e.g. `g:terminal_color_0`)
	dim_inactive = {
		enabled = false,        -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15,      -- percentage of the shade to apply to the inactive window
	},
	no_italic = false,          -- Force no italic
	no_bold = false,            -- Force no bold
	no_underline = false,       -- Force no underline
	styles = {                  -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
		-- miscs = {}, -- Uncomment to turn off hard-coded styles
	},
	color_overrides = {},
	custom_highlights = function(colors)
		return {
			-- Custom color for Type
			["@type"] = { fg = colors.red },
			["@type.builtin"] = { fg = colors.red },
			Type = { fg = colors.red },

			-- Mason boarder and transparent background 
			MasonNormal = { bg = "NONE" },
			MasonBorder = { fg = colors.blue, bg = "NONE" },
			TelescopeNormal = { bg = "NONE"},
		}
	end,
	default_integrations = true,
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = true,
		dap = true,
		dap_ui = true,
		mason = true,
		fzf = true,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		telescope = {
			enabled = true
		},
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})
vim.cmd.colorscheme "catppuccin"

--Костыль на сброс фона telescope окна
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE", fg = "#7aa2f7" })
-- Фикс для go.nvim окон (аналогично вашему костылю для Telescope)
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
