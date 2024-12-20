require "nvchad.mappings"
local map = vim.keymap.set

-- General
map("n", ";", ":", { desc = "General enter command mode", nowait = true })
map("n", "<leader>rcu", function()
  require("crates").upgrade_all_crates()
end, { desc = "General rust update crates" })
map("n", "<leader>p", "<cmd>PasteImage<cr>", { desc = "General paste clipboard image" })
map("n", "<leader>zz", function()
  require("zen-mode").toggle {
    window = {
      width = 0.9, -- width will be 85% of the editor width
    },
  }
end, { desc = "General Starts zen mode and twilight" })
map("n", "<leader>ng", ":Neogit<CR>", { desc = "General Enter Neogit", noremap = true })
map("n", "<leader>fm", function()
  require("conform").format { async = true, lsp_format = "fallback" }
end, { desc = "General format", noremap = true })

map("v", ">", ">gv", { desc = "General indent" })

map({ "v", "i" }, "jk", "<esc>", { desc = "General escape" })

map("n", "<C-nt>", 'i<C-R>=strftime("%Y-%m-%d %a %H:%M %Z")<CR>--<Esc>', { desc = "General Print time", silent = true })
map("i", "<C-nt>", '<C-R>=strftime("%Y-%m-%d %a %H:%M %Z")<CR>--', { desc = "General Print time", silent = true })
map("i", "<C-nh>", ">>>", { desc = "General insert note header" })
map("n", "<C-nh>", "i>>><esc>", { desc = "General insert note header" })
map("n", "zz", ":update<CR>", { desc = "General save document" })
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
map("n", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "DAP Continue from breakpoint" })
map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "DAP run last" })
map("n", "<leader>dp", function()
  require("dap").repl.open()
end, { desc = "DAP open repl" })
map("n", "<leader>dso", function()
  require("dap").step_over()
end, { desc = "DAP Step over" })
map("n", "<leader>dsi", function()
  require("dap").step_into()
end, { desc = "DAP Step into" })
map("n", "<leader>dsu", function()
  require("dap").step_out()
end, { desc = "DAP Step out(up)" })
-- LSP
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP [C]ode [A]ction" })
map("n", "<leader>tl", function()
  lint.try_lint()
end, { desc = "LSP Trigger linting" })

-- Trouble
map({ "n" }, "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble Diagnostics (Trouble)" })
map(
  { "n" },
  "<leader>xX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Trouble Buffer Diagnostics (Trouble)" }
)
map({ "n" }, "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Trouble Symbols (Trouble)" })
map(
  { "n" },
  "<leader>cl",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "Trouble LSP Definitions / references / ... (Trouble)" }
)
map({ "n" }, "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble Location List (Trouble)" })
map({ "n" }, "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble Quickfix List (Trouble)" })

-- Telescope
map({ "n", "v" }, "<leader>sc", function()
  local builtin = require "telescope.builtin"
  builtin.spell_suggest(require("telescope.themes").get_cursor {})
end, { desc = "Telescope spellcheck " })

-- Switch pane
map("n", "<C-h>", function()
  local args = { same_row = boolean, at_edge = "wrap" }
  require("smart-splits").move_cursor_left(args)
end, { desc = "Splits Move Pane Left" })
map("n", "<C-l>", function()
  local args = { same_row = boolean, at_edge = "wrap" }
  require("smart-splits").move_cursor_right(args)
end, { desc = "Splits Move Pane Right" })
map("n", "<C-k>", function()
  local args = { same_row = boolean, at_edge = "wrap" }
  require("smart-splits").move_cursor_up(args)
end, { desc = "Splits Move Pane Up" })
map("n", "<C-j>", function()
  local args = { same_row = boolean, at_edge = "wrap" }
  require("smart-splits").move_cursor_down(args)
end, { desc = "Splits Move Pane Down" })

-- Resize pane
map("n", "<M-h>", function()
  require("smart-splits").resize_left(5)
end, { desc = "Splits Resize Pane Left" })
map("n", "<M-l>", function()
  require("smart-splits").resize_right(5)
end, { desc = "Splits Resize Pane Right" })
map("n", "<M-k>", function()
  require("smart-splits").resize_up(5)
end, { desc = "Splits Resize Pane Up" })
map("n", "<M-j>", function()
  require("smart-splits").resize_down(5)
end, { desc = "Splits Resize Pane Down" })
map("n", "<leader>rs", function()
  require("smart-splits").start_resize_mode()
end, { desc = "Splits Start Resize Mode" })

-- Menu
-- Keyboard users
map("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-- mouse users + nvimtree users!
map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})
