vim.api.nvim_create_user_command("Zen", function(opts)
	---@type integer
	local val = ({ ["d"] = 2, ["e"] = 0 })[string.sub(opts.fargs[1] or "", 1, 1)]
		or ({ [0] = 2, [2] = 0 })[vim.o.laststatus]
		or vim.o.laststatus
	vim.o.laststatus = val
	vim.o.showtabline = val
end, {
	desc = "Control zen mode (No status lines)",
	nargs = "?",
	complete = function() return { "enable", "disable" } end,
})
