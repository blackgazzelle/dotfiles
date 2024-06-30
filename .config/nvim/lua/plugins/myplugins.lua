local overrides = require "configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
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
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        python = { "ruff" },
        markdown = { "mdformat" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        rust = { "rustfmt" },
        cmake = { "cmake_format" },
        yaml = { "yamlfix" },
        toml = { "taplo" },
      },
      -- Set up format-on-save
      ["_"] = { "trim_whitespace" },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
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
    opts = {
      overrides.mason,
      ensure_installed = {
        "clang-format",
        "clangd",
        "css-lsp",
        "deno",
        "html-lsp",
        "lua-language-server",
        "prettier",
        "prettierd",
        "taplo",
        "yamlfix",
        "stylua",
        "typescript-language-server",
        "rust-analyzer",
        "beautysh",
        "pyright",
        "bash-language-server",
        "marksman",
        "mdformat",
        "codespell",
        "ruff",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      overrides.treesitter,
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
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
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
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
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
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
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
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
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
    "vimpostor/vim-tpipeline",
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
}
return plugins
