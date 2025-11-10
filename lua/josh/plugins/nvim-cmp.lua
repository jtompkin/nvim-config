-- This plugin is lazy-loaded
-- Load mini.snippets before this plugin
Lib.pack_add_on_event(
	{ "InsertEnter", "CmdlineEnter" },
	vim.iter({
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"abeldekat/cmp-mini-snippets",
	})
		:map(Lib.from_gh)
		:totable(),
	function()
		local cmp = require("cmp")
		local mini_snippets = require("mini.snippets")
		cmp.setup({
			enabled = function()
				local disabled = false
				disabled = disabled or (vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt")
				disabled = disabled or (vim.fn.reg_recording() ~= "")
				disabled = disabled or (vim.fn.reg_executing() ~= "")
				disabled = disabled or require("cmp.config.context").in_treesitter_capture("comment")
				return not disabled
			end,
			snippet = {
				expand = function(args)
					local insert = mini_snippets.config.expand.insert or mini_snippets.default_insert
					insert({ body = args.body })
					cmp.resubscribe({ "TextChangedI", "TextChangedP" })
					require("cmp.config").set_onetime({ sources = {} })
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "mini_snippets" },
			}, {
				{ name = "buffer" },
			}),
		})
		local cmdline_mapping = cmp.mapping.preset.cmdline()
		cmdline_mapping["<C-j>"] = cmdline_mapping["<Tab>"]
		cmdline_mapping["<C-k>"] = cmdline_mapping["<S-Tab>"]
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmdline_mapping,
			sources = {
				{ name = "buffer" },
			},
		})
		cmp.setup.cmdline(":", {
			mapping = cmdline_mapping,
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})
	end
)
