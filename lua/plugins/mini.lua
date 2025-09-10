return {
	"nvim-mini/mini.nvim",
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
		require("mini.comment").setup({
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		})

		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({
			n_lines = 500,
			custom_textobjects = {
				o = require("mini.ai").gen_spec.treesitter({
					a = "@block.outer",
					i = "@block.inner",
				}),
				f = require("mini.ai").gen_spec.treesitter({
					a = "@function.outer",
					i = "@function.inner",
				}),
				c = require("mini.ai").gen_spec.treesitter({
					a = "@class.outer",
					i = "@class.inner",
				}),
				t = require("mini.ai").gen_spec.treesitter({
					a = "@tag.outer",
					i = "@tag.inner",
				}),
			},
		})
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
