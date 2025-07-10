return {
	"echasnovski/mini.nvim",
	version = "*",
	dependencies = {
		"folke/snacks.nvim",
	},
	config = function()
		require("mini.statusline").setup()
		require("mini.icons").setup()
		require("mini.surround").setup({ n_lines = 50 })
		require("mini.pairs").setup()
		require("mini.move").setup()
		require("mini.git").setup()

		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })
		-- local gen_spec = require("mini.ai").gen_spec
		-- require("mini.ai").setup({
		-- 	n_lines = 500,
		-- 	custom_textobjects = {
		-- 		-- Function definition (needs treesitter queries with these captures)
		-- 		f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
		-- 		c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
		--
		-- 		-- Make `|` select both edges in non-balanced way
		-- 		["|"] = gen_spec.pair("|", "|", { type = "non-balanced" }),
		-- 	},
		-- })
	end,
}
