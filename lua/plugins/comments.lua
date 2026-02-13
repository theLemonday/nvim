return {
	-- { "LudoPinelli/comment-box.nvim", opts = {} },
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	{
		"nvim-mini/mini.comment",
		version = false,
		config = function()
			require("mini.comment").setup({
				options = {
					custom_commentstring = function()
						return require("ts_context_commentstring.internal").calculate_commentstring()
							or vim.bo.commentstring
					end,
				},
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		optional = true,
		keys = {
			{ "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
			{
				"<leader>sT",
				function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end,
				desc = "Todo/Fix/Fixme",
			},
		},
	},
}
