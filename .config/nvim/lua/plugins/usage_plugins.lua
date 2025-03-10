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
				desc = "buffer local keymaps (which-key)",
			},
		},
	},
	{
		"echasnovski/mini.files",
		version = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function(_, opts)
			require("configs/minifiles")
		end,
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
		config = function()
			require("auto-session").setup({
				use_git_branch = true,
				suppressed_dirs = { "/", "~/Downloads", "~/.config" },
				lazy_support = true,
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
}
