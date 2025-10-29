local M = {}
M.from_gh = function(repo)
	return "https://github.com/" .. repo
end
M.pack_add_group = vim.api.nvim_create_augroup("pack-add", {})
M.pack_add_on_event = function(event, specs, setup, opts)
	vim.api.nvim_create_autocmd(
		event,
		vim.tbl_extend("force", opts or {}, {
			group = M.pack_add_group,
			callback = function()
				vim.pack.add(specs)
				setup()
			end,
		})
	)
end
return M
