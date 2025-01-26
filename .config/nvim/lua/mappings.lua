local map = vim.keymap.set
local builtin = require("telescope.builtin")

-- MiniFiles
map("n", "-", function()
	local MiniFiles = require("mini.files")
	local minifiles_toggle = function(...)
		if not MiniFiles.close() then
			MiniFiles.open(...)
		end
	end
	minifiles_toggle()
end, { desc = "Minifiles Open" })

-- General
map("n", ";", ":", { desc = "General enter command mode", nowait = true })
map("n", "<leader>rcu", function()
	require("crates").upgrade_all_crates()
end, { desc = "General rust update crates" })
map("n", "<leader>p", "<cmd>PasteImage<cr>", { desc = "General paste clipboard image" })
map("n", "<leader>ng", ":Neogit<CR>", { desc = "General Enter Neogit", noremap = true })

map("n", "<leader>fm", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "General format", noremap = true })
map("v", ">", ">gv", { desc = "General indent" })
map({ "v", "i" }, "jk", "<esc>", { desc = "General escape" })
map("n", "<C-nt>", 'i<C-R>=strftime("%Y-%m-%d %a %H:%M %Z")<CR>--<Esc>', { desc = "General Print time", silent = true })
map("i", "<C-nt>", '<C-R>=strftime("%Y-%m-%d %a %H:%M %Z")<CR>--', { desc = "General Print time", silent = true })
map("i", "<C-nh>", ">>>", { desc = "General insert note header" })
map("n", "<C-nh>", "i>>><esc>", { desc = "General insert note header" })
map("n", "zz", ":update<CR>", { desc = "General save document" })

-- Telescope
map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- Dap
local dap = require("dap")
local dapui = require("dapui")
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "DAP Toggle breakpoint" })
map("n", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "DAP Continue from breakpoint" })
map("n", "<leader>ds", function()
	dap.continue()
	dapui.toggle({})
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
end, { desc = "DAP Start session" })
map("n", "<leader>de", function()
	-- Close debugger and clear breakpoints
	dap.clear_breakpoints()
	dapui.toggle({})
	dap.terminate()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
	require("notify")("Debugger session ended", "warn")
end)
map("n", "<leader>dl", function()
	dap.run_last()
end, { desc = "DAP run last" })
map("n", "<leader>dp", function()
	dap.repl.open()
end, { desc = "DAP open repl" })
map("n", "<leader>do", function()
	dap.step_over()
end, { desc = "DAP Step over" })
map("n", "<leader>di", function()
	dap.step_into()
end, { desc = "DAP Step into" })
map("n", "<leader>du", function()
	dap.step_out()
end, { desc = "DAP Step out(up)" })

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

-- Switch pane
local smartsplits = require("smart-splits")
map("n", "<C-h>", function()
	local args = { same_row = boolean, at_edge = "wrap" }
	smartsplits.move_cursor_left(args)
end, { desc = "Splits Move Pane Left" })
map("n", "<C-l>", function()
	local args = { same_row = boolean, at_edge = "wrap" }
	smartsplits.move_cursor_right(args)
end, { desc = "Splits Move Pane Right" })
map("n", "<C-k>", function()
	local args = { same_row = boolean, at_edge = "wrap" }
	smartsplits.move_cursor_up(args)
end, { desc = "Splits Move Pane Up" })
map("n", "<C-j>", function()
	local args = { same_row = boolean, at_edge = "wrap" }
	smartsplits.move_cursor_down(args)
end, { desc = "Splits Move Pane Down" })

-- Resize pane
map("n", "<M-h>", function()
	smartsplits.resize_left(5)
end, { desc = "Splits Resize Pane Left" })
map("n", "<M-l>", function()
	smartsplits.resize_right(5)
end, { desc = "Splits Resize Pane Right" })
map("n", "<M-k>", function()
	smartsplits.resize_up(5)
end, { desc = "Splits Resize Pane Up" })
map("n", "<M-j>", function()
	smartsplits.resize_down(5)
end, { desc = "Splits Resize Pane Down" })
map("n", "<leader>rs", function()
	smartsplits.start_resize_mode()
end, { desc = "Splits Start Resize Mode" })

-- Todo keys
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- Zen
map("n", "<leader>z", function()
	Snacks.zen()
end, { desc = "Toggle Zen Mode" })
map("n", "<leader>Z", function()
	Snacks.zen.zoom()
end, { desc = "Toggle Zoom" })

-- Scratch buff
map("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", function()
	Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })

-- Notifs
map("n", "<leader>n", function()
	Snacks.notifier.show_history()
end, { desc = "Notification History" })
map("n", "<leader>un", function()
	Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })

-- Buffers
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
map("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
map("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
map("n", "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })

-- Reanme
map("n", "<leader>cR", function()
	Snacks.rename.rename_file()
end, { desc = "Rename File" })

-- Term
map("n", "<c-/>", function()
	Snacks.terminal()
end, { desc = "Toggle Terminal" })
map("n", "<c-_>", function()
	Snacks.terminal()
end, { desc = "which_key_ignore" })

-- Jumps
map({ "n", "t" }, "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
map({ "n", "t" }, "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

-- Noice
map("n", "<leader>sn", "", { desc = "+noice" })
map("c", "<S-Enter>", function()
	require("noice").redirect(vim.fn.getcmdline())
end, { desc = "Redirect Cmdline" })
map("n", "<leader>snl", function()
	require("noice").cmd("last")
end, { desc = "Noice Last Message" })
map("n", "<leader>snh", function()
	require("noice").cmd("history")
end, { desc = "Noice History" })
map("n", "<leader>sna", function()
	require("noice").cmd("all")
end, { desc = "Noice All" })
map("n", "<leader>snd", function()
	require("noice").cmd("dismiss")
end, { desc = "Dismiss All" })
map("n", "<leader>snt", function()
	require("noice").cmd("pick")
end, { desc = "Noice Picker (Telescope/FzfLua)" })
map({ "n", "i", "s" }, "<c-f>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-f>"
	end
end, { silent = true, expr = true, desc = "Scroll Forward" })
map({ "n", "i", "s" }, "<c-b>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-b>"
	end
end, { silent = true, expr = true, desc = "Scroll Backward" })

-- LSP
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP go to declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP go to definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP go to implementation" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "LSP add workspace folder" })
map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "LSP remove workspace folder" })
map("n", "<space>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "LSP list workspace folder" })
map("n", "<space>D", vim.lsp.buf.type_definition, { desc = "LSP type definition" })
map("n", "<space>rn", vim.lsp.buf.rename, { desc = "LSP rename" })
map({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
map("n", "gr", vim.lsp.buf.references, { desc = "LSP show references" })
