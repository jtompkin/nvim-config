vim.pack.add({ Lib.from_gh("neovim/nvim-lspconfig") })

---@param server string
---@param config vim.lsp.Config?
local function config_and_enable(server, config)
	vim.lsp.config(server, config or {})
	vim.lsp.enable(server)
end

config_and_enable("emmylua_ls", {
	settings = {
		emmylua = {
			workspace = {
				library = { ".", vim.env.VIMRUNTIME, vim.fn.stdpath("data") .. "/site/pack/core/opt" },
			},
			runtime = {
				version = "LuaJIT",
			},
		},
	},
})
config_and_enable("gopls")
config_and_enable("just")
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
config_and_enable("basedpyright", {
	handlers = {
		["$/progress"] = function(err, result, ctx)
			-- just notify once
			if result.token == (vim.g.basedpyright_progress_token or result.token) then
				vim.g.basedpyright_progress_token = result.token
				vim.lsp.handlers["$/progress"](err, result, ctx)
			end
		end,
	},
})
