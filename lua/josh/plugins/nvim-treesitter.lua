local autocmd = vim.api.nvim_create_autocmd
autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			vim.cmd.TSUpdate()
		end
	end,
})
vim.pack.add({
	{
		src = Lib.from_gh("nvim-treesitter/nvim-treesitter"),
		version = "main",
	},
})
local default_langs = {
	"bash",
	"c",
	"comment",
	"csv",
	"diff",
	"go",
	"gomod",
	"json",
	"lua",
	"make",
	"markdown",
	"markdown_inline",
	"nix",
	"powershell",
	"python",
	"r",
	"toml",
	"vim",
	"vimdoc",
}
require("nvim-treesitter").install(default_langs):wait(300000)
autocmd("FileType", {
	pattern = default_langs,
	callback = function()
		vim.treesitter.start()
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
