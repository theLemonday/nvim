return {
	"mistweaverco/kulala.nvim",
	opts = {},
	ft = "http",
	config = function()
		local wk = require("which-key")
		wk.add({ "<leader>r", group = "[R]equest" })
	end,
	keys = {
		{
			"<leader>rr",
			function()
				require("kulala").run()
			end,
			desc = "[R]equest [R]un",
		},
		{
			"<leader>r]",
			function()
				require("kulala").jump_next()
			end,
			desc = "[R]equest next",
		},
		{
			"<leader>r[",
			function()
				require("kulala").jump_prev()
			end,
			desc = "[R]equest prev",
		},
		{
			"<leader>ri",
			function()
				require("kulala").inspect()
			end,
			desc = "[R]equest [I]nspect",
		},
		{
			"<leader>ry",
			function()
				require("kulala").copy()
			end,
			desc = "[R]equest [Y]ank (to curl)",
		},
		{
			"<leader>ry",
			function()
				require("kulala").from_curl()
			end,
			desc = "[R]equest [P]aste (to curl)",
		},
	},
}
