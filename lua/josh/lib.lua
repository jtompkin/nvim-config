local lib = {}
---@param repo string Owner and repo name separated by "/"
---@return string url Full GitHub repo URL
lib.from_gh = function(repo) return "https://github.com/" .. repo end
lib.pack_add_group = vim.api.nvim_create_augroup("pack-add", {})
---@param event vim.api.keyset.events|vim.api.keyset.events[]
---@param specs (string|vim.pack.Spec)[]
---@param setup fun(): nil
---@param opts vim.api.keyset.create_autocmd?
lib.pack_add_on_event = function(event, specs, setup, opts)
	vim.api.nvim_create_autocmd(
		event,
		vim.tbl_extend("force", opts or {}, {
			group = lib.pack_add_group,
			callback = function()
				vim.pack.add(specs)
				setup()
			end,
		})
	)
end

lib.json = require("lib.json")

return lib
