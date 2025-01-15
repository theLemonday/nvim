return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach", -- Or `LspAttach`
	priority = 1000, -- needs to be loaded in first
	opts = { preset = "minimal" },
	-- config = function()
	-- 	require("tiny-inline-diagnostic").setup()
	-- end,
}
