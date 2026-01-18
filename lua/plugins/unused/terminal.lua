return {
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			terminal = {},
		},
		keys = {
			{
				"<leader>tt",
				function() Snacks.terminal.toggle() end,
				desc = "[T]oggle [T]erminal",
			},
		},
	},
}
