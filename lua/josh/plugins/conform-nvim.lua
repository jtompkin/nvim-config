-- This plugin is lazy-loaded
Lib.pack_add_on_event("FileType", {
	Lib.from_gh("stevearc/conform.nvim"),
}, function()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			markdown = { "injected" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end, { pattern = { "lua", "python", "go", "gomod", "gowork", "gotmpl", "markdown" } })
