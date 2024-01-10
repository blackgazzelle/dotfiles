---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle breakpoint"
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require("dap.ui.widgets");
      end,
      "Open debugging sidebar"
    },
    ["<leader>rcu"] = {
      function ()
        require("crates").upgrade_all_crates()
      end,
      "update crates"
    },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!

return M
