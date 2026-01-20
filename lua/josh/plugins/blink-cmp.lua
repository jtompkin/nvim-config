vim.pack.add({
	{ src = Lib.from_gh("Saghen/blink.cmp"), version = vim.version.range("~1") },
	Lib.from_gh("rafamadriz/friendly-snippets"),
})
require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-l>"] = { "snippet_forward" },
		["<C-h>"] = { "snippet_backward" },
		["<C-e>"] = { "hide", "fallback" },
		["<C-S-e>"] = { "cancel", "fallback" },
		["<C-S-Space>"] = {
			"show",
			"show_documentation",
			"hide_documentation",
		},
		["<C-g>"] = { "show_signature", "hide_signature", "fallback" },
		["<C-u>"] = { "scroll_signature_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<C-n>"] = false,
		["<C-p>"] = false,
	},
	signature = { enabled = true },
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		ghost_text = { enabled = true },
	},
	sources = { providers = { snippets = { opts = { extended_filetypes = {
		lua = { "luadoc" },
	} } } } },
	cmdline = {
		keymap = { preset = "inherit" },
		completion = { menu = { auto_show = true } },
	},
})
