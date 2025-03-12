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
			image = { enabled = true },
			bigfile = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			scope = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			dashboard = {
				sections = {
					{ section = "header" },
					{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ section = "startup" },
				},
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
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	},
	{ "MunifTanjim/nui.nvim", lazy = true },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},

		config = function(_, opts)
			-- HACK: noice shows messages from before it was enabled,
			-- but this is not ideal when Lazy is installing plugins,
			-- so clear the messages in this case.
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)
		end,
	},

	{ "sindrets/diffview.nvim" },
}
