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
			lua = { "stylua", lsp_format = "never" },
			python = { "ruff_format" },
			markdown = { "injected" },
			ps1 = { lsp_format = "first", "trim_whitespace", stop_after_first = false },
			pyproject = { "tombi" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end, { pattern = { "lua", "python", "go", "gomod", "gowork", "gotmpl", "markdown", "ps1", "pyproject" } })
