---@class Pack
---@field active boolean
---@field branches string[]
---@field path string
---@field rev string
---@field spec vim.pack.SpecResolved
---@field tags? string[]
vim.api.nvim_create_user_command("PackList", function(opts)
	local arg = opts.fargs[1]
	if arg == "pretty" then
		vim.pack.update(nil, { offline = true })
		return
	end
	local function packs_to_buffer(packs) ---@param packs string[]
		if #packs == 0 then
			vim.notify("No packages to show")
			return
		end
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, packs)
		vim.api.nvim_buf_set_keymap(buf, "n", "q", "<CMD>q<CR>", {})
		local win = vim.api.nvim_open_win(
			buf,
			true,
			{ relative = "win", row = 0, col = 3, width = 20, height = #packs, style = "minimal" }
		)
		vim.api.nvim_set_option_value("number", true, { scope = "local", win = win })
	end
	local packs = vim.iter(vim.pack.get())
	if arg == "unused" then
		packs_to_buffer(packs
			:filter(function(pack) ---@param pack Pack
				return not pack.active
			end)
			:map(function(pack) ---@param pack Pack
				return pack.spec.name
			end)
			:totable())
	else
		packs_to_buffer(packs
			:map(function(pack) ---@param pack Pack
				return pack.spec.name
			end)
			:totable())
	end
end, {
	complete = function()
		return { "pretty", "unused", "all" }
	end,
	nargs = "?",
	desc = "List packages",
})

vim.api.nvim_create_user_command("PackDelete", function(opts)
	vim.pack.del(opts.fargs)
end, {
	nargs = "+",
	desc = "Delete packages from disk",
})

vim.api.nvim_create_user_command("PackUpdate", function(opts)
	local packs
	if #opts.fargs == 0 then
		packs = nil
	else
		packs = opts.fargs
	end
	vim.pack.update(packs)
	vim.api.nvim_buf_set_keymap(0, "n", "q", "<CMD>q<CR>", {})
end, { nargs = "*", desc = "Update packages" })
