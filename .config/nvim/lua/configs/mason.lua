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
		"ansible-language-server",
		"clang-format",
		"cmake-language-server",
		"prettier",
		"taplo",
		"yamlfix",
		"stylua",
		"cpptools",
		"clangd",
		"css-lsp",
		"deno",
		"html-lsp",
		"lua-language-server",
		"prettierd",
		"rust-analyzer",
		"beautysh",
		"pyright",
		"bash-language-server",
		"marksman",
		"ruff",
		"buf",
		"harper-ls",
		"typescript-language-server",
		"codelldb",
		"gopls",
	},
})

require("configs/mason_dap")
