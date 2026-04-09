-- Optional: load nvim-cmp before this plugin for capabilities
vim.pack.add(vim.tbl_map(Lib.from_gh, { "neovim/nvim-lspconfig" }))

---@param server string
---@param config vim.lsp.Config
local function config_and_enable(server, config)
	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end

config_and_enable("emmylua_ls", {})
config_and_enable("gopls", {})
config_and_enable("ty", {})
config_and_enable("powershell_es", {
	bundle_path = "C:/Users/tompk/Programs/PowerShellEditorServices",
	settings = {
		powershell = {
			codeFormatting = {
				preset = "OTBS",
				ignoreOneLineBlock = true,
				whitespaceBeforeOpenBrace = true,
				whitespaceAroundOperator = true,
				whitespaceAroundPipe = true,
				trimWhitespaceAroundPipe = true,
			},
		},
	},
})
