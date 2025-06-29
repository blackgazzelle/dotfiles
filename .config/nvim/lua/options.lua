-- General
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a" -- allow the mouse to be used in Nvim

-- Session restoring
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Tab
vim.opt.tabstop = 4 -- number of visual spaces per TAB
vim.opt.softtabstop = 4 -- number of spacesin tab when editing
vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right
vim.opt.termguicolors = true -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = false -- we are experienced, wo don't need the "-- INSERT --" mode hint
vim.opt.conceallevel = 2 -- conceal for norg
vim.opt.colorcolumn = "120" -- max code line

-- Searching
vim.opt.incsearch = true -- search as characters are entered
-- vim.opt.hlsearch = false            -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

-- Folds
vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function()
		if require("nvim-treesitter.parsers").has_parser() then
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		else
			vim.opt.foldmethod = "syntax"
		end

		if vim.bo.filetype == "ptnotes" then
			vim.opt.foldmethod = "marker"
			vim.opt.foldmarker = ">>>,<<<"
			vim.opt.iskeyword:append(".")
			vim.opt.iskeyword:append("-")
		end
		vim.opt.foldenable = false
	end,
})

-- Format command
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

-- Snacks functions
-- snacks.rename
vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesActionRename",
	callback = function(event)
		Snacks.rename.on_rename_file(event.data.from, event.data.to)
	end,
})

-- Clipboard + fix for wezterm (https://github.com/wezterm/wezterm/discussions/5231)
-- -- Sync clipboard between OS and Neovim.
-- Function to set OSC 52 clipboard
local function set_osc52_clipboard()
	local function my_paste()
		local content = vim.fn.getreg('"')
		return vim.split(content, "\n")
	end

	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = {
			["+"] = my_paste,
			["*"] = my_paste,
		},
	}
end

-- Check if the current session is a remote WezTerm session based on the WezTerm executable
local function check_wezterm_remote_clipboard(callback)
	local wezterm_executable = vim.uv.os_getenv("WEZTERM_EXECUTABLE")

	if wezterm_executable and wezterm_executable:find("wezterm-mux-server", 1, true) then
		callback(true) -- Remote WezTerm session found
	else
		callback(false) -- No remote WezTerm session
	end
end

-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
	vim.opt.clipboard:append("unnamedplus")

	-- Standard SSH session handling
	if vim.uv.os_getenv("SSH_CLIENT") ~= nil or vim.uv.os_getenv("SSH_TTY") ~= nil then
		set_osc52_clipboard()
	else
		check_wezterm_remote_clipboard(function(is_remote_wezterm)
			if is_remote_wezterm then
				set_osc52_clipboard()
			end
		end)
	end
end)
