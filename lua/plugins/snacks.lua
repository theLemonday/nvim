return {
	{

		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = {
				enabled = true,
				sections = {
					{ section = "header" },
					{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
					{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ section = "startup" },
				},
			},
			indent = { enabled = true },
			input = { enabled = true },
			-- notifier = { enabled = true },
			quickfile = { enabled = true },
			-- scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			picker = {
				enabled = true,
				ui_select = true,
			},
		},
		keys = {
			{
				"<leader><space>",
				function()
					Snacks.picker.buffers()
				end,
				desc = "[ ] existing buffers",
			},
			-- LSP
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "[g]o [d]efinitions",
			},
			{
				"gr",
				function()
					Snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "[g]o [r]eferences",
			},
			{
				"gI",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "[g]o [I]mplementation",
			},
			{
				"gy",
				function()
					Snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition",
			},
			-- Search
			{
				'<leader>s"',
				function()
					Snacks.picker.registers()
				end,
				desc = "Registers",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "[k]eymap",
			},
			{
				"<leader>sf",
				function()
					Snacks.picker.files()
				end,
				desc = "[f]ile",
			},
			{
				"<leader>sn",
				function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "[n]eovim files",
			},
			{
				"<leader>sR",
				function()
					Snacks.picker.resume()
				end,
				desc = "[R]esume",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP [s]ymbols",
			},
			{
				"<leader>sC",
				function()
					Snacks.picker.commands()
				end,
				desc = "[c]ommands",
			},
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "[d]iagnostics",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				desc = "[h]elp",
			},
			{
				"<leader>sq",
				function()
					Snacks.picker.qflist()
				end,
				desc = "[q]uickfix list",
			},
			{
				"<leader>sp",
				function()
					Snacks.picker.projects()
				end,
				desc = "[p]roject",
			},
			-- Grep
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "[g]rep",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "visual selection or [w]ord",
				mode = { "n", "x" },
			},
			-- git
			{
				"<leader>gc",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		optional = true,
		keys = {
			{
				"<leader>st",
				function()
					Snacks.picker.todo_comments()
				end,
				desc = "Todo",
			},
		},
	},
	{
		"folke/trouble.nvim",
		optional = true,
		specs = {
			"folke/snacks.nvim",
			opts = function(_, opts)
				return vim.tbl_deep_extend("force", opts or {}, {
					picker = {
						actions = require("trouble.sources.snacks").actions,
						win = {
							input = {
								keys = {
									["<c-t>"] = {
										"trouble_open",
										mode = { "n", "i" },
									},
								},
							},
						},
					},
				})
			end,
		},
	},
}
