vim.opt.termguicolors = true
local res = vim.system({ "darkman", "get" }, { text = true }):wait()
local theme = vim.env.LIGHT_THEME
-- Default to light theme
if vim.trim(res.stdout) == "dark" then theme = vim.env.DARK_THEME end

return {
	{
		"RRethy/base16-nvim",
		init = function() vim.cmd("colorscheme base16-" .. theme) end,
	},
	-- {
	-- 	"rachartier/tiny-inline-diagnostic.nvim",
	-- 	event = "VeryLazy",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("tiny-inline-diagnostic").setup({
	-- 			preset = "classic",
	-- 			options = {
	-- 				show_source = {
	-- 					if_many = true,
	-- 				},
	-- 				multilines = { enabled = true },
	-- 				severity = {
	-- 					vim.diagnostic.severity.ERROR,
	-- 					vim.diagnostic.severity.WARN,
	-- 				},
	-- 			},
	-- 		})
	-- 		vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
	-- 	end,
	-- },
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
