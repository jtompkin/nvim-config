vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "blink.cmp" and (kind == "install" or kind == "update") then
			local is_windows = Lib.is_windows()
			if is_windows then
				vim.system({ "rustup", "override", "set", "nightly-x86_64-pc-windows-gnu" }, { cwd = ev.data.path })
					:wait()
			end
			vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path }):wait()
			if is_windows then
				vim.system({ "rustup", "override", "unset" }, { cwd = ev.data.path }):wait()
			end
		end
	end,
})
vim.pack.add({
	Lib.from_gh("Saghen/blink.cmp"),
	Lib.from_gh("rafamadriz/friendly-snippets"),
})
require("blink.cmp").setup({
	fuzzy = { implementation = "rust" },
	keymap = {
		preset = "default",
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-l>"] = { "snippet_forward" },
		["<C-h>"] = { "snippet_backward" },
		["<C-e>"] = { "cancel", "fallback" },
		["<C-]>"] = { function(cmp) cmp.show({ providers = { "snippets" } }) end },
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
		accept = { auto_brackets = { enabled = false } },
		ghost_text = { enabled = true },
	},
	sources = {
		providers = {
			snippets = { opts = { extended_filetypes = {
				lua = { "luadoc" },
				python = { "pydoc" },
			} } },
		},
	},
	cmdline = {
		keymap = { preset = "inherit" },
		completion = { menu = { auto_show = true } },
	},
})
