---@type snacks.picker.Config
local snacksPickerConfig = {
	win = {
		input = {
			keys = {
				["<c-e>"] = {
					function(picker)
						require("zk").new({ title = picker:text() })
						picker:close()
					end,
					mode = { "i", "n" },
					desc = "Create new note",
				},
			},
		},
	},
}

return {
	"zk-org/zk-nvim",
	lazy = true,
	dependencies = {
		"folke/snacks.nvim",
	},
	config = function()
		require("zk").setup({
			picker = "snacks_picker",
		})
	end,
	keys = {
		{
			"<leader>zn",
			function()
				Snacks.input.input({
					prompt = "Title",
				}, function(title) require("zk").new({ title = title }) end)
			end,
			desc = "[Z]k [N]ew with title",
		},
		{
			"<leader>ze",
			function()
				require("zk").edit(
					{ sort = { "modified" } },
					{ snacks_picker = snacksPickerConfig }
				)
			end,
			desc = "[Z]k [E]dit",
		},
		-- { "<leader>zo",function (
		--
		-- )
		-- 	require("zk").
		-- end "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", desc = "[Z]k [O]pen" },
		{ "<leader>zt", "<Cmd>ZkTags<CR>", desc = "[Z]k open by [T]ags" },
		{
			"<leader>zf",
			"<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
			desc = "[Z]k [F]ind",
		},
		{
			"<leader>zf",
			":'<,'>ZkMatch<CR>",
			desc = "[Z]k find [M]atches selection",
			mode = { "v" },
		},
	},
}
