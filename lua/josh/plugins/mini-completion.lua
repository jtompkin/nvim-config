-- This plugin is lazy-loaded
Lib.pack_add_on_event("InsertEnter", { Lib.from_gh("nvim-mini/mini.completion") }, function()
	require("mini.completion").setup({
		delay = {
			completion = 50,
			info = 50,
			signature = 25,
		},
	})
end)
