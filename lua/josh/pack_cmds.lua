---@class Pack
---@field active boolean
---@field branches string[]
---@field path string
---@field rev string
---@field spec vim.pack.SpecResolved
---@field tags? string[]

local function packs_to_window(packs) ---@param packs string[]
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

vim.api.nvim_create_user_command("PackList", function(args)
	local arg = args.fargs[1]
	if arg == "pretty" then
		vim.pack.update(nil, { offline = true })
		return
	end
	if arg == "inactive" then
		packs_to_window(vim.tbl_map(
			function(pack) ---@param pack Pack
				return pack.spec.name
			end,
			vim.tbl_filter(function(pack) ---@param pack Pack
				return not pack.active
			end, vim.pack.get())
		))
		return
	end
	if vim.fn.executable("jq") == 1 then
		local packs_string = vim.system({ "jq", "-r", ".plugins|keys[]", "nvim-pack-lock.json" }, { text = true })
			:wait().stdout or ""
		packs_to_window(vim.split(string.sub(packs_string, 1, #packs_string - 1), "\n"))
	else
		packs_to_window(vim.tbl_map(function(pack)
			return pack.spec.name
		end, vim.pack.get()))
	end
end, {
	complete = function()
		return { "pretty", "inactive", "all" }
	end,
	nargs = "?",
	desc = "List installed packages",
})

vim.api.nvim_create_user_command("PackDelete", function(args)
	vim.pack.del(args.fargs)
end, { nargs = "+", desc = "Delete installed packages from disk" })

vim.api.nvim_create_user_command("PackUpdate", function(args)
	local packs
	if #args.fargs > 0 then
		packs = args.fargs
	end
	vim.pack.update(packs)
end, { nargs = "*", desc = "Update installed packages" })
