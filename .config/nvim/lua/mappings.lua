require "nvchad.mappings"
local map = vim.keymap.set

-- General
map("n", ";", ":", { desc = "General enter command mode", nowait = true })
map("n", "<leader>rcu", function()
  require("crates").upgrade_all_crates()
end, { desc = "General rust update crates" })
map("n", "<leader>p", "<cmd>PasteImage<cr>", { desc = "General paste clipboard image" })
map("n", "<leader>z", function()
  require("zen-mode").toggle {
    window = {
      width = 0.9, -- width will be 85% of the editor width
    },
  }
end, { desc = "General Starts zen mode and twilight" })
map("n", "<leader>lg", ":LazyGit<CR>", { desc = "General Enter LazyGit", noremap = true })
map("n", "<leader>fm", ":Format", { desc = "General format", noremap = true })

map("v", ">", ">gv", { desc = "General indent" })

map({ "v", "i" }, "jk", "<esc>", { desc = "General escape" })

-- Venn
map("n", "<leader>dr", function()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.cmd [[setlocal ve=all]]
    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
    -- draw a box by pressing "f" with visual selection
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
  else
    vim.cmd [[setlocal ve=]]
    vim.cmd [[mapclear <buffer>]]
    vim.b.venn_enabled = nil
  end
end, { desc = "Starts Venn mode" })
map("n", "<leader>drJ", "<C-v>j:VBox<CR>", { desc = "Venn J Down Arrow", noremap = true })
map("n", "<leader>drK", "<C-v>k:VBox<CR>", { desc = "Venn K Up Arrow", noremap = true })
map("n", "<leader>drL", "<C-v>l:VBox<CR>", { desc = "Venn K Right Arrow", noremap = true })
map("n", "<leader>drH", "<C-v>h:VBox<CR>", { desc = "Venn K Left Arrow", noremap = true })

map("v", "<leader>drf", ":VBox<CR>", { desc = "Venn Surround Visual Selection in a box", noremap = true })

-- Dap
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "DAP Toggle breakpoint" })
map("n", "<leader>dus", function()
  local widgets = require "dap.ui.widgets"
end, { desc = "DAP Open debugging sidebar" })
map("n", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "DAP Continue from breakpoint" })

-- LSP
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP [C]ode [A]ction" })
map("n", "<leader>tl", function()
  lint.try_lint()
end, { desc = "LSP Trigger linting" })
