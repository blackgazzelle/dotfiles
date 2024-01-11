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
    ["<leader>p"] = {
      "<cmd>PasteImage<cr>","Paste clipboard image"
    },
    ["<leader>z"] = {
      function ()
        require("zen-mode").toggle({
          window = {
            width = .9 -- width will be 85% of the editor width
          }
        })
      end,
      "Starts zen mode and twilight"
    },
      },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

M.venn = {
 n = {
    ["<leader>dr"] = {
      function ()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd[[setlocal ve=all]]
          -- draw a line on HJKL keystokes
          vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
          vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
          vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
          vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
          -- draw a box by pressing "f" with visual selection
          vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
        else
          vim.cmd[[setlocal ve=]]
          vim.cmd[[mapclear <buffer>]]
          vim.b.venn_enabled = nil
        end
      end,
      "Starts Venn mode"
    },
    ["<leader>drJ"] = { "<C-v>j:VBox<CR>", "J Down Arrow", opts={noremap = true}},
    ["<leader>drK"] = { "<C-v>k:VBox<CR>", "K Up Arrow", opts={noremap = true}},
    ["<leader>drL"] = { "<C-v>l:VBox<CR>", "K Right Arrow", opts={noremap = true}},
    ["<leader>drH"] = { "<C-v>h:VBox<CR>", "K Left Arrow", opts={noremap = true}},

    }
}

-- more keybinds!

return M
