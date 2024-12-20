return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
        },
      }
      require("telescope").load_extension "ui-select"
      require("telescope").load_extension "session-lens"
    end,
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
    },
    lazy = false,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },

    -- Everything in opts will be passed to setup()
    opts = require "configs.conform",
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
      "BufWritePre",
    },
    config = function()
      require "configs.nvim-lint"
    end,
  },

  {
    "williamboman/mason.nvim",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",
        "python",
        "bash",

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
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        enable = true,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup {
        auto_session_use_git_branch = true,
        auto_save_enabled = true,
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/", "~/Desktop" },
      }
    end,
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "mfussenegger/nvim-dap",
    ft = { "python", "c", "c++", "rust" },
    dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap-python", "nvim-neotest/nvim-nio" },
    config = function()
      require "configs.dap"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },

  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    lazy = false, -- This plugin is already lazy
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "nvchad.configs.cmp"
      table.insert(M.sources, { name = "crates" })
      table.insert(M.sources, { name = "neorg" })
      return M
    end,
  },

  {
    "HakonHarnes/img-clip.nvim",
    lazy = false,
    event = "BufEnter",
  },

  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    "jbyuki/venn.nvim",
    lazy = false,
  },

  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python", "lua" }, -- etc
    -- [Optional] cmp-conjure for cmp
    dependencies = {
      {
        "PaterJason/cmp-conjure",
        config = function()
          local cmp = require "cmp"
          local config = cmp.get_config()
          table.insert(config.sources, {
            name = "buffer",
            option = {
              sources = {
                { name = "conjure" },
              },
            },
          })
          cmp.setup(config)
        end,
      },
    },
    config = function(_, opts)
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
    init = function()
      -- Set configuration options here
      vim.g["conjure#debug"] = true
      vim.g["conjure#extract#tree_sitter#enabled"] = true
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
  },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
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
      require("neorg").setup {
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
      }
    end,
  },
  -- lazy.nvim

  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
    lazy = true,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway
    opts = function()
      local presets = require "markview.presets"
      require("markview").setup {
        modes = { "n", "i", "nc", "c" },
        hybrid_modes = { "n", "nc", "c" },
        checkboxes = presets.checkboxes.nerd,
        headings = presets.headings.arrowed,
      }
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
