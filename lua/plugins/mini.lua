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
		-- require("mini.bracketed").setup()
		require("mini.pairs").setup()

		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		local gen_spec = require("mini.ai").gen_spec
		require("mini.ai").setup({
			n_lines = 500,
			custom_textobjects = {
				-- Function definition (needs treesitter queries with these captures)
				f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
				c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class

				-- Make `|` select both edges in non-balanced way
				["|"] = gen_spec.pair("|", "|", { type = "non-balanced" }),
			},
		})

		-- require("mini.files").setup({ mappings = { synchronize = "-" }, options = { permanent_delete = false } })
		-- local Snacks = require("snacks")
		-- vim.api.nvim_create_autocmd("User", {
		-- 	pattern = "MiniFilesActionRename",
		-- 	callback = function(event)
		-- 		Snacks.rename.on_rename_file(event.data.from, event.data.to)
		-- 	end,
		-- })
	end,
	-- keys = {
	-- 	{
	-- 		"-",
	-- 		function()
	-- 			require("mini.files").open()
	-- 		end,
	-- 		desc = "Open mini files explorer",
	-- 	},
	-- },
}
