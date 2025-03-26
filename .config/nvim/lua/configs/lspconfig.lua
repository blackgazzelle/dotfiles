local map = vim.keymap.set
local on_attach = function(_, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end

	map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
	map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
	map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))

	map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))

	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
	map("n", "gr", vim.lsp.buf.references, opts("Show references"))
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "bashls", "marksman", "taplo", "buf_ls", "lua_ls", "ts_ls", "cmake", "ansiblels" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

--
local path = util.path

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

lspconfig.pyright.setup({
	root_dir = function(fname)
		return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname)
			or util.path.dirname(fname)
	end,
	settings = {
		pyright = { autoImportCompletion = true },
		python = {
			analysis = {
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "off",
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
				disableOrganizeImports = true,
			},
		},
	},
})

lspconfig.ruff.setup({
	autostart = os.getenv("DISABLE_RUFF") ~= "1",
	on_attach = function(client, bufnr)
		client.server_capabilities.hoverProvider = false
		on_attach(client, bufnr)
	end,
	settings = {
		prioritizeFileConfiguration = true,
		fixAll = true,
		organizeImports = true,
	},
})

lspconfig.clangd.setup({
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "cc", "h", "hh", "hpp" },
})

lspconfig.harper_ls.setup({
	settings = {
		["harper-ls"] = {
			codeActions = {
				forceStable = true,
			},
		},
	},
})
