Lib.pack_add_on_event("InsertEnter", { Lib.from_gh("nvim-mini/mini.surround") }, function()
	require("mini.surround").setup({})
end)
