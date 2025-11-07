-- NOTE: This plugin is lazy-loaded
Lib.pack_add_on_event("InsertEnter", { Lib.from_gh("nvim-mini/mini.surround") }, function()
	require("mini.surround").setup({
		-- Add prefix to not mangle default 's' mapping
		mappings = {
			add = "<leader>sa",
			delete = "<leader>sd",
			find = "<leader>sf",
			find_left = "<leader>sF",
			highlight = "<leader>sh",
			replace = "<leader>sr",
		},
	})
end)
