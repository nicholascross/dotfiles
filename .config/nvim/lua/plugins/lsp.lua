return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.sourcekit.setup {
        capabilities = { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } },
        offset_encoding = "utf-8"
      }

      lspconfig.bashls.setup {
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "zsh" }
      }

      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            runtime = {
              -- Use LuaJIT for Neovim
              version = 'LuaJIT',
              -- Setup your Lua path
              path = vim.split(package.path, ';')
            },
            diagnostics = {
              -- Recognize the `vim` global
              globals = { 'vim' }
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file('', true),
              -- Suppress prompt to configure third-party tools
              checkThirdParty = false
            },
            telemetry = {
              -- Disable telemetry data collection
              enable = false
            }
          }
        }
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = "LSP Actions",
        callback = function(args)
          -- vim.keymap.set("n", "K", vim.lsp.buf.hover, {noremap = true, silent = true})
          -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, {noremap = true, silent = true})

        end
      })
    end
  }
}
