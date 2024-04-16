---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "highlights"
M.ui = {
  theme = "nord",
  theme_toggle = { "nord", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
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
}

-- M.plugins = "plugins"

-- check core.mappings for table structure
-- M.mappings = require "mappings"

return M
