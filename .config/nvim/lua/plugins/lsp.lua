return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("sourcekit", {
        capabilities = { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } },
        offset_encoding = "utf-8"
      })

      vim.lsp.config("bashls", {
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "zsh" }
      })

      vim.lsp.config("lua_ls", {
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
        },
	      })

	      vim.lsp.enable("sourcekit")
	      vim.lsp.enable("bashls")
	      vim.lsp.enable("lua_ls")
	      local ok, err = pcall(vim.lsp.enable, "copilot")
	      if not ok then
	        vim.notify(("copilot LSP unavailable: %s"):format(err), vim.log.levels.WARN)
	      end

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
