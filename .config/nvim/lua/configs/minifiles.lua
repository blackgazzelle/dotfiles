local MiniFiles = require("mini.files")
local map = vim.keymap.set
MiniFiles.setup({})

local show_dotfiles = true

local filter_show = function(fs_entry)
	return true
end

local filter_hide = function(fs_entry)
	return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
	show_dotfiles = not show_dotfiles
	local new_filter = show_dotfiles and filter_show or filter_hide
	MiniFiles.refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		-- Tweak left-hand side of mapping to your liking
		map("n", "g.", toggle_dotfiles, { buffer = buf_id })
	end,
})

local map_split = function(buf_id, lhs, direction)
	local rhs = function()
		-- Make new window and set it as target
		local new_target_window
		vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
			vim.cmd(direction .. " split")
			new_target_window = vim.api.nvim_get_current_win()
		end)

		MiniFiles.set_target_window(new_target_window)
	end

	-- Adding `desc` will result into `show_help` entries
	local desc = "Split " .. direction
	map("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		-- Tweak keys to your liking
		map_split(buf_id, "gs", "belowright horizontal")
		map_split(buf_id, "gv", "belowright vertical")
	end,
})

local files_set_cwd = function(path)
	-- Works only if cursor is on the valid file system entry
	local cur_entry_path = MiniFiles.get_fs_entry().path
	local cur_directory = vim.fs.dirname(cur_entry_path)
	vim.fn.chdir(cur_directory)
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		map("n", "g~", files_set_cwd, { buffer = args.data.buf_id })
	end,
})
