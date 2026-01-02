vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesActionRename",
	callback = function(event) Snacks.rename.on_rename_file(event.data.from, event.data.to) end,
})

return {
	"nvim-mini/mini.nvim",
	version = false,
	dependencies = {
		"folke/snacks.nvim",
	},
	config = function()
		require("mini.statusline").setup()
		require("mini.icons").setup()
		require("mini.surround").setup({ n_lines = 50 })
		-- require("mini.pairs").setup()
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
			content = {
				filter = function(entry)
					return entry.name ~= ".DS_Store"
						and entry.name ~= ".git"
						and entry.name ~= ".direnv"
				end,
				sort = function(entries)
					-- technically can filter entries here too, and checking gitignore for _every entry individually_
					-- like I would have to in `content.filter` above is too slow. Here we can give it _all_ the entries
					-- at once, which is much more performant.
					local all_paths = table.concat(
						vim.tbl_map(function(entry) return entry.path end, entries),
						"\n"
					)
					local output_lines = {}
					local job_id = vim.fn.jobstart({ "git", "check-ignore", "--stdin" }, {
						stdout_buffered = true,
						on_stdout = function(_, data) output_lines = data end,
					})

					-- command failed to run
					if job_id < 1 then return entries end

					-- send paths via standard input
					vim.fn.chansend(job_id, all_paths)
					vim.fn.chanclose(job_id, "stdin")
					vim.fn.jobwait({ job_id })
					return require("mini.files").default_sort(
						vim.tbl_filter(
							function(entry) return not vim.tbl_contains(output_lines, entry.path) end,
							entries
						)
					)
				end,
			},
			mappings = {
				go_in_plus = "<CR>",
			},
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
			-- custom_textobjects = {
			-- 	o = require("mini.ai").gen_spec.treesitter({
			-- 		a = "@block.outer",
			-- 		i = "@block.inner",
			-- 	}),
			-- 	f = require("mini.ai").gen_spec.treesitter({
			-- 		a = "@function.outer",
			-- 		i = "@function.inner",
			-- 	}),
			-- 	c = require("mini.ai").gen_spec.treesitter({
			-- 		a = "@class.outer",
			-- 		i = "@class.inner",
			-- 	}),
			-- 	t = require("mini.ai").gen_spec.treesitter({
			-- 		a = "@tag.outer",
			-- 		i = "@tag.inner",
			-- 	}),
			-- },
		})

		require("mini.cmdline").setup()
	end,
	keys = {
		{ "-", function() MiniFiles.open(vim.fn.expand("%:p:h")) end, desc = "Open MiniFiles" },
	},
}
