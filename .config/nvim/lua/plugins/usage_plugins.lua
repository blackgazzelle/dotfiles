return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			keymaps = {
				["<leader>h"] = { "actions.select", opts = { horizontal = true } },
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	},
	{
		"mrjones2014/smart-splits.nvim",
		lazy = false,
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("session-lens")
		end,
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
		},
		lazy = false,
	},

	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("auto-session").setup({
				auto_session_use_git_branch = true,
				auto_save_enabled = true,
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/", "~/Desktop" },
			})
		end,
	},
	{
		"HakonHarnes/img-clip.nvim",
		lazy = false,
		event = "BufEnter",
	},
	{
		"NeogitOrg/neogit",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true,
	},

	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		config = true,
	},

	{
		"nvim-neorg/neorg",
		version = "*", -- Pin Neorg to the latest stable release
		ft = "norg",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},

					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/Nextcloud/Share/Notes/",
								projects = "~/Projects/",
							},
						},
					},
				},
			})
		end,
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
}
