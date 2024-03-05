local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
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
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("custom.configs.null-ls")
        end,
      },
    },
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
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
        "stylua",
        "typescript-language-server",
        "black",
        "isort",
        "mypy",
        "flake8",
        "rust-analyzer",
        "beautysh",
        "cpplint",
        "pyright",
        "autopep8",
        "bash-language-server",
        "marksman",
        "markdownlint",
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
      require("auto-session").setup({
        auto_session_use_git_branch = true,
        auto_save_enabled = true,
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/", "~/Desktop" },
      })
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
      return require("custom.configs.rust-tools")
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    ft = { "python", "c", "c++", "rust" },
    dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap-python" },
    config = function()
      require("custom.configs.dap")
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require("plugins.configs.cmp")
      table.insert(M.sources, { name = "crates" })
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
          local cmp = require("cmp")
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
    "davidmh/cspell.nvim",
  },
  {
    "vimpostor/vim-tpipeline",
    lazy = false,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "~/Nextcloud/Notes/",
        },
        {
          name = "GT",
          path = "~/Nextcloud/Notes/GT/",
        },
        {
          name = "THM",
          path = "~/Nextcloud/Notes/thm/",
        },
      },

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Journal",
      },
      templates = {
        subdir = "templates",
      },
    },
  },
}

return plugins
