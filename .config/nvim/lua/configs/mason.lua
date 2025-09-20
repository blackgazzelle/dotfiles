local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")
mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	max_concurrent_installers = 10,
})

mason_lspconfig.setup({
	lazy = true,
})

mason_tool_installer.setup({
	lazy = true,
	auto_update = true,
	integrations = {
		["mason-lspconfig"] = true,
	},
	ensure_installed = {
		"ansible-lint",
		"clang-format",
		"clangd",
		"cmake-language-server",
		"cpptools",
		"deno",
		"gopls",
		"harper-ls",
		"lua-language-server",
		"marksman",
		"rust-analyzer",
		"ruff",
		"stylua",
		"taplo",
		"yamlfix",
	},
})

require("configs/mason_dap")
