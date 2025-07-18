require("toggleterm").setup{
	size = 15,
	-- Горячая клавиша для открытия/закрытия терминала
	open_mapping = [[<c-\>]],
	-- Направление открытия терминала (horizontal, vertical, float, tab)
	direction = 'horizontal',
	-- Закрывать терминал при выходе из процесса
	close_on_exit = true,
	-- Дополнительные настройки:
	hide_numbers = true,  -- Скрыть номера в терминале
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,   -- Затемнение фона (число от 1 до 3)
	start_in_insert = true,
	insert_mappings = true,  -- Разрешить маппинги в insert режиме
	terminal_mappings = true,  -- Разрешить маппинги в terminal режиме
	persist_size = true,
	persist_mode = true,
	auto_scroll = true,  -- Автопрокрутка при выводе
}
