-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "nord",

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

M.ui = {
  statusline = {
    theme = "vscode_colored",
  },

  nvdash = {
    load_on_startup = true,
    header = {
      "   ▗█▗▖                   ",
      "  ▗▗▓▒▓▓▓▓▓               ",
      "  ▗▗▄▓▒▓▒▒▄▄▄▓            ",
      "   ▐█▓▓▒▒▒▒▒▒▄▄▓▖  ▗  ▗▚▖▗",
      "   ▓▒▄▓▓▓▓▒▒▒▀▀▐▄▙▄▙▄▄▄▖▖▖",
      "     ▄▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▝▀▚▄ ",
      "     ▄▓▓▓▓▓▒▓▒▒▒▄▓▖▓▓▖▄▞▀ ",
      "     ▀█▗▓▒▒▒▒▓▓▓▓▓▄███▖▘  ",
      "     ▄▓▓▓▓▓▓▓▓▄███▛▀▀▀▘   ",
      "   ▐█▓▓▓▓▓▄██████▓▄▒      ",
      "  ▗▗▓▓▓▗█████▒▄██▒▄██     ",
      " █▓▓▓▄▒▗█████▒▄████▒▗█▖   ",
      " ▀▗██▒▗█████████████▗▒▄▌  ",
      "  ▓▐█▒▒▒▒▒▒▒▒▒▄███▒▒▒▒▄▌  ",
      "   ░ ▄▒▒▒▄███▒▒▒▒▒▒▒▗██░  ",
      "   ▐█▒▒▒▒▒▒▒▒▄█▄▄▒▒▗▗▓▓▗█ ",
      "   ▐█▒▒▒▒▒▒▒▒▄▒▒▒▒▒▒▗▄▄▄█ ",
      "   ▐█▒▒▒▒▒▒▒▒▄▒▒▒▒▒▗▗▒▄▌  ",
      "   ▐█▄▒▒▒▒▒▒▒▄▄▄▄▒▒▗▗▒▄▌  ",
      "     ▄▒▒▒▒▒▗▄▒▒▒▒▒▄▒▒▒▟▌  ",
      "     ▄▒▒▒▒▒▗█▒▒▒▒▄▒▒▒▒▄▌  ",
      "   ▗▄▒▗▗▒▒▗▗▒▒▄▄▄▒▒▒▒▒▄▌  ",
      "  ▗▗▒▒▒▗██▒▒▒▒▒▒▒▒▒▒▒▒▒▗▟ ",
      "  ▝▐████▀▀█████████████▛▀ ",
      "   ▝▓▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓▓▘  ",
    },
  },

  term = {
    winopts = { number = true, relativenumber = true }
  }
}

M.mason = {
  pkgs = {
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
      "rust-analyzer",
      "beautysh",
      "pyright",
      "bash-language-server",
      "marksman",
      "mdformat",
      "codespell",
      "ruff",
      "buf",
      "harper-ls",
  },
}


return M
