-- This plugin is lazy-loaded
Lib.pack_add_on_event(
	{ "InsertEnter", "CmdlineEnter" },
	{ Lib.from_gh("nvim-mini/mini.snippets"), Lib.from_gh("rafamadriz/friendly-snippets") },
	function()
		local mini_snippets = require("mini.snippets")
		mini_snippets.setup({
			snippets = {
				mini_snippets.gen_loader.from_lang(),
			},
		})
	end
)
