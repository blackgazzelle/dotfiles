local nord = vim.fn.stdpath("data") .. "/lazy/nord.nvim"
vim.opt.rtp:append(nord)

local colorscheme = "nord"
local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
