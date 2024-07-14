local lint = require "lint"

lint.linters_by_ft = {
  python = { "ruff" },
  protobuf = { "buf" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
