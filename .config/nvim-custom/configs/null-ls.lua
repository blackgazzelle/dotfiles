local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions
local sources = {

  -- webdev stuff
  formatting.deno_fmt, -- chose deno for ts/js files cuz its very fast!
  formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  formatting.stylua,

  -- c/cpp
  formatting.clang_format,
  lint.cpplint,

  -- python
  formatting.black,
  formatting.isort,
  formatting.autopep8,
  lint.flake8,
  lint.mypy,

  -- bash
  formatting.beautysh,

  -- spellcheck
  lint.cspell,
  actions.cspell,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
