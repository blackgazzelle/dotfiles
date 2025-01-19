-- Set leaders
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Setup lazy.nvim
require("colorscheme")
require("configs.lazy")
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	checker = { enabled = true },
})

-- Do other options and keymaps
require("options")
require("mappings")
