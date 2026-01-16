vim.pack.add({ Lib.from_gh("DrKJeff16/wezterm-types") })
Lib.pack_add_on_event("FileType", {
	Lib.from_gh("folke/lazydev.nvim"),
}, function()
	require("lazydev").setup({
		library = {
			{ path = "wezterm-types", mods = { "wezterm" } },
		},
	})
end, { pattern = { "lua" } })
