---@class Pack
---@field active boolean
---@field branches string[]
---@field path string
---@field rev string
---@field spec vim.pack.SpecResolved
---@field tags? string[]
vim.api.nvim_create_user_command("PackUnused", function()
	local packs = vim.iter(vim.pack.get())
		:filter(function(pack)
			return not pack.active
		end)
		:map(function(pack)
			return pack.spec.name
		end)
		:totable()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, 0, false, packs)
	vim.api.nvim_open_win(buf, true, { split = "right", win = 0 })
end, { desc = "Print all inactive packages to the notification system" })

vim.api.nvim_create_user_command("PackList", function()
	vim.pack.update(nil, { offline = true })
end, { desc = "List all installed packages" })

vim.api.nvim_create_user_command("PackDel", function(opts)
	vim.pack.del(opts.fargs)
end, {
	nargs = "+",
	desc = "Delete packages from disk",
})
