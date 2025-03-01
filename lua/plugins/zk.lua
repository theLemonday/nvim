return {
	"zk-org/zk-nvim",
	config = function()
		require("zk").setup({
			-- See Setup section below
		})
	end,
	keys = {
		{
			"<leader>zd",
			"<Cmd>ZkNew { group = 'journal/daily' }<CR>",
			desc = "[d]aily",
			noremap = true,
			silent = false,
		},
		{
			"<leader>zn",
			"<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
			desc = "[n]ew",
			noremap = true,
			silent = false,
		},
		{
			"<leader>zf",
			"<Cmd>ZkNew { title = vim.fn.input('Fleet note title: '), dir='fleet' }<CR>",
			desc = "[f]leet",
			noremap = true,
			silent = false,
		},
		{
			"<leader>zs",
			"<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
			desc = "[s]earch",
			noremap = true,
			silent = false,
		},
	},
}
