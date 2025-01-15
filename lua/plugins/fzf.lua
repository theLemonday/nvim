return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({})
	end,
	keys = {
		{
			"<leader>sh",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "[S]earch [H]elp",
		},
		{
			"<leader>sk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "[S]earch [K]eymap",
		},
		{
			"<leader>sf",
			function()
				require("fzf-lua").files()
			end,
			desc = "[S]earch [F]ile",
		},
		{
			"<leader>sw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "[S]earch current [W]ord",
		},
		{
			"<leader>sg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "[S]earch [G]rep",
		},
		{
			"<leader>sr",
			function()
				require("fzf-lua").resume()
			end,
			desc = "[S]earch [R]esume",
		},
		{
			"<leader>s.",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "[S]earch Recent Files ('.' for repeat)",
		},
		{
			"<leader><leader>",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "[ ] Find existing buffers",
		},
		{
			"<leader>sn",
			function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "[S]earch [N]eovim files",
		},
		{
			"<leader>sd",
			function()
				require("fzf-lua").diagnostics()
			end,
			desc = "[S]earch [D]iagnostics",
		},
		{
			"<leader>ca",
			function()
				require("fzf-lua").lsp_code_actions()
			end,
			desc = "[C]ode [A]ction",
		},
		{
			"<leader>ns",
			function()
				require("fzf-lua").files({ cwd = "~/notes" })
			end,
			desc = "[N]ote [S]earch",
		},
		{
			"<leader>sc",
			function()
				require("fzf-lua").commands()
			end,
			desc = "[S]earch [C]ommand",
		},
		{
			"<leader>sS",
			function()
				require("fzf-lua").lsp_workspace_symbols()
			end,
			desc = "[S]earch [S]ymbol (Workspace)",
		},
		{
			'<leader>s"',
			function()
				require("fzf-lua").registers()
			end,
			desc = "[S]earch [R]egister",
		},
	},
}
