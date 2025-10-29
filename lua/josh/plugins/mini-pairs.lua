-- This plugin is lazy-loaded
Lib.pack_add_on_event("InsertEnter", { Lib.from_gh("nvim-mini/mini.pairs") }, function()
	require("mini.pairs").setup({})
end)
