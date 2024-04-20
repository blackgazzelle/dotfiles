local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    python = { "autopep8", "black", "isort", "autoflake" },
    markdown = { "markdownlint" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    rust = { "rustfmt" },
    cmake = { "cmake_format" },
    yaml = { "yamlfix" },
    toml = { "taplo" },
  },

  -- Use the "*" filetype to run formatters on all filetypes.
  ["*"] = { "codespell" },
  -- Use the "_" filetype to run formatters on filetypes that don't
  -- have other formatters configured.
  ["_"] = { "trim_whitespace" },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
