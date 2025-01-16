local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

local servers = {
  "pyright",
  "ruff",
}

local ts_servers = {"tsserver", "tailwindcss", "eslint"}

for _, lsp in ipairs(ts_servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"python"},
  })
end

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"rust"},
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    ['rust_analyzer'] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
})


lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.clangd.setup{
  on_attach = function (client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}
lspconfig.omnisharp.setup({
  cmd = { "omnisharp" },  -- Path to the omnisharp executable
  root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj"),  -- Detect project root via solution or csproj
  filetypes = {"cs", "cshtml"},
  settings = {
    omnisharp = {
      enableRoslynAnalyzers = true,
      organizeImports = true,
      codeAction = {
        enable = true,
      },
      formatting = {
        enable = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Keybindings and other configuration for OmniSharp LSP
    -- Example: Show hover documentation on <K> press
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<K>', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
  end,
})
