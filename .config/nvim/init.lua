require('options')

-- Setup lazy.nvim
require("configs.lazy")
require("lazy").setup({
    spec = {
        { import = "plugins"},
    },
    checker = { enabled = true },
})

require('mappings')
require('colorscheme')

