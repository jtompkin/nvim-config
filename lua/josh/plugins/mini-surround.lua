-- NOTE: This plugin is lazy-loaded
Lib.pack_add_on_event("InsertEnter", { Lib.from_gh("nvim-mini/mini.surround") }, function()
	require("mini.surround").setup({
		-- Add prefix to not mangle default 's' mapping
		mappings = {
			add = "<leader>ra",
			delete = "<leader>rd",
			find = "<leader>rf",
			find_left = "<leader>rF",
			highlight = "<leader>rh",
			replace = "<leader>rr",
		},
	})
end)
