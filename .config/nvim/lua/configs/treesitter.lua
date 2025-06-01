vim.filetype.add({
	pattern = {
		[".*pt.txt"] = "ptnotes",
	},
})
local options = {
	ensure_installed = {
		-- defaults
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"markdown_inline",
		"lua",
		"python",
		"bash",
		"norg",
		"regex",
		"latex",
		"scss",
		"svelte",
		"tsx",
		"typst",
		"vue",

		-- web
		"html",
		"css",
		"javascript",
		"json",

		-- low level
		"c",
		"zig",
		"cpp",
		"rust",
		"go",
	},
	highlight = {
		enable = true,
	},
	indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
vim.treesitter.language.register("bash", "ptnotes")
