local function remove_single_blank_lines()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local new_lines = {}

	local i = 1
	while i <= #lines do
		local line = lines[i]
		if line:match("^%s*$") then
			-- Count how many consecutive blank lines
			local count = 1
			while i + count <= #lines and lines[i + count]:match("^%s*$") do
				count = count + 1
			end
			-- Keep blank lines only if there are 2 or more in a row
			if count > 1 then
				for _ = 1, count do
					table.insert(new_lines, "")
				end
			end
			i = i + count
		else
			table.insert(new_lines, line)
			i = i + 1
		end
	end

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
end

vim.api.nvim_create_user_command(
	"RemoveSingleBlankLines",
	remove_single_blank_lines,
	{ desc = "Remove only single blank lines" }
)
