return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim", -- still useful for non-toolbox tools
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      ------------------------------------------------------------------
      -- Shared config
      ------------------------------------------------------------------
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      -- toolbox helper
      local function toolbox_cmd(cmd)
        return {
          "toolbox",
          "run",
          "bash",
          "-lc",
          unpack(cmd),
        }
      end

      ------------------------------------------------------------------
      -- JS / TS (Node + nvm inside toolbox)
      ------------------------------------------------------------------
      vim.lsp.config("tsserver", {
        cmd = toolbox_cmd({
          "typescript-language-server",
          "--stdio",
        }),
        filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = {
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
    ".git",
  }, capabilities = capabilities, on_attach = function(client, bufnr)
          -- Prettier handles formatting
          client.server_capabilities.documentFormattingProvider = false
          on_attach(client, bufnr)
        end,
      })
      vim.lsp.enable("tsserver")

      ------------------------------------------------------------------
      -- Python
      ------------------------------------------------------------------
      vim.lsp.config("pyright", {
        cmd = toolbox_cmd({ "pyright-langserver", "--stdio" }),
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("pyright")

      ------------------------------------------------------------------
      -- PHP
      ------------------------------------------------------------------
      vim.lsp.config("intelephense", {
        cmd = toolbox_cmd({ "intelephense", "--stdio" }),
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          intelephense = {
            files = {
              maxSize = 1000000,
            },
          },
        },
      })
      vim.lsp.enable("intelephense")

      ------------------------------------------------------------------
      -- Go
      ------------------------------------------------------------------
      vim.lsp.config("gopls", {
        cmd = toolbox_cmd({ "gopls" }),
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          gopls = {
            gofumpt = true,
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })
      vim.lsp.enable("gopls")
    end,
  },
}
