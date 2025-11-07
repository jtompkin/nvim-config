-- This plugin is lazy-loaded
Lib.pack_add_on_event(
	{ "InsertEnter", "CmdlineEnter" },
	{ Lib.from_gh("nvim-mini/mini.snippets"), Lib.from_gh("rafamadriz/friendly-snippets") },
	function()
		local mini_snippets = require("mini.snippets")
		mini_snippets.setup({
			mappings = {
				expand = "<C-S>",
				jump_prev = "<C-L>",
			},
			snippets = {
				-- Load custom file with global snippets first (adjust for Windows)
				-- gen_loader.from_file("~/.config/nvim/snippets/global.json"),

				-- Load snippets based on current language by reading files from
				-- "snippets/" subdirectories from 'runtimepath' directories.
				mini_snippets.gen_loader.from_lang(),
			},
		})
	end
)
