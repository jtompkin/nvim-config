-- This plugin is lazy-loaded
vim.filetype.add({ filename = { ["pyproject.toml"] = "pyproject" } })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "pyproject",
	callback = function(args) vim.treesitter.start(args.buf, "toml") end,
})
Lib.pack_add_on_event("FileType", {
	Lib.from_gh("stevearc/conform.nvim"),
}, function()
	require("conform").setup({
		formatters_by_ft = {
			go = { "gofmt" },
			just = { "just" },
			lua = { "stylua", lsp_format = "never" },
			markdown = { "injected" },
			ps1 = { lsp_format = "first", "trim_whitespace" },
			pyproject = { "tombi" },
			python = { "ruff_format" },
			v = { lsp_format = "prefer" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = {
			timeout_ms = 500,
		},
	})
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end, {
	pattern = {
		"go",
		"gomod",
		"gotmpl",
		"gowork",
		"just",
		"lua",
		"markdown",
		"ps1",
		"pyproject",
		"python",
		"v",
	},
})
