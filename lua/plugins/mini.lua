vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesActionRename",
	callback = function(event) Snacks.rename.on_rename_file(event.data.from, event.data.to) end,
})

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

		require("mini.files").setup({
			options = { permanent_delete = false },
			windows = { preview = true },
		})

		require("mini.notify").setup()

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
	end,
	keys = {
		{ "-", function() MiniFiles.open(vim.fn.expand("%:p:h")) end, desc = "Open MiniFiles" },
	},
}
