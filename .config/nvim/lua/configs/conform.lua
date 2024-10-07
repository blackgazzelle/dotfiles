local options = {
  -- Define your formatters
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    python = { "ruff" },
    markdown = { "prettierd", "prettier" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    rust = { "rustfmt" },
    cmake = { "cmake_format" },
    yaml = { "yamlfix" },
    toml = { "taplo" },
    proto = { "buf" },
  },

  -- Set up format-on-save
  ["_"] = { "trim_whitespace" },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
