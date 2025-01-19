return {
	{ "shaunsingh/nord.nvim" },
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = { -- set to setup table
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			dashboard = {
				preset = {
					header = [[ 
                      ▗█▗▖                   
                     ▗▗▓▒▓▓▓▓▓               
                     ▗▗▄▓▒▓▒▒▄▄▄▓            
                      ▐█▓▓▒▒▒▒▒▒▄▄▓▖  ▗  ▗▚▖▗
                      ▓▒▄▓▓▓▓▒▒▒▀▀▐▄▙▄▙▄▄▄▖▖▖
                        ▄▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▝▀▚▄ 
                        ▄▓▓▓▓▓▒▓▒▒▒▄▓▖▓▓▖▄▞▀ 
                        ▀█▗▓▒▒▒▒▓▓▓▓▓▄███▖▘  
                        ▄▓▓▓▓▓▓▓▓▄███▛▀▀▀▘   
                      ▐█▓▓▓▓▓▄██████▓▄▒      
                     ▗▗▓▓▓▗█████▒▄██▒▄██     
                    █▓▓▓▄▒▗█████▒▄████▒▗█▖   
                    ▀▗██▒▗█████████████▗▒▄▌  
                     ▓▐█▒▒▒▒▒▒▒▒▒▄███▒▒▒▒▄▌  
                      ░ ▄▒▒▒▄███▒▒▒▒▒▒▒▗██░  
                      ▐█▒▒▒▒▒▒▒▒▄█▄▄▒▒▗▗▓▓▗█ 
                      ▐█▒▒▒▒▒▒▒▒▄▒▒▒▒▒▒▗▄▄▄█ 
                      ▐█▒▒▒▒▒▒▒▒▄▒▒▒▒▒▗▗▒▄▌  
                      ▐█▄▒▒▒▒▒▒▒▄▄▄▄▒▒▗▗▒▄▌  
                        ▄▒▒▒▒▒▗▄▒▒▒▒▒▄▒▒▒▟▌  
                        ▄▒▒▒▒▒▗█▒▒▒▒▄▒▒▒▒▄▌  
                      ▗▄▒▗▗▒▒▗▗▒▒▄▄▄▒▒▒▒▒▄▌  
                     ▗▗▒▒▒▗██▒▒▒▒▒▒▒▒▒▒▒▒▒▗▟ 
                     ▝▐████▀▀█████████████▛▀ 
                      ▝▓▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓▓▘  
                    ]],
				},
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({})
		end,
	},
}
