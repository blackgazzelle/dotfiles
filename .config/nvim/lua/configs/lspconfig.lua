local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "bashls", "marksman", "taplo", "bufls", "lua_ls", "ts_ls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

--
local path = util.path

lspconfig.pyright.setup {
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
}

lspconfig.ruff.setup {
  autostart = os.getenv "DISABLE_RUFF" ~= "1",
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
    on_attach(client, bufnr)
  end,
  settings = {
    prioritizeFileConfiguration = true,
    fixAll = true,
    organizeImports = true,
  },
}

lspconfig.clangd.setup {
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "cc", "h", "hh", "hpp" },
}

lspconfig.harper_ls.setup {
  settings = {
    ["harper-ls"] = {
      codeActions = {
        forceStable = true,
      },
    },
  },
}
