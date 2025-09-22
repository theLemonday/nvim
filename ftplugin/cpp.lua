-- F5: Build
vim.api.nvim_set_keymap(
	"n",
	"<F5>",
	":w<CR>:!g++ % -std=c++17 -O2 -Wall -Wextra -o %:r<CR>",
	{ noremap = true, silent = true }
)

-- F6: Run in terminal for manual input
vim.api.nvim_set_keymap("n", "<F6>", ":w<CR>:terminal ./%:r<CR>", { noremap = true, silent = true })
