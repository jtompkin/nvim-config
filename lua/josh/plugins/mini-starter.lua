vim.pack.add({ Lib.from_gh("nvim-mini/mini.starter") })
local mini_starter = require("mini.starter")
mini_starter.setup({
	evaluate_single = true,
	items = {
		mini_starter.sections.sessions(),
		mini_starter.sections.builtin_actions(),
		mini_starter.sections.pick(),
	},
})
