return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
    lspconfig.sourcekit.setup {
      capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = "LSP Actions",
        callback = function(args)
          --vim.keymap.set("n", "K", vim.lsp.buf.hover, {noremap = true, silent = true})
          --vim.keymap.set("n", "gd", vim.lsp.buf.definition, {noremap = true, silent = true})

	  local wk = require('which-key')
	  wk.register({
		  { "K", vim.lsp.buf.hover, desc = "LSP hover info" },
		  { "[g", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic" },
		  { "gD", vim.lsp.buf.declaration, desc = "LSP go to declaration" },
		  { "g]", vim.diagnostic.goto_next, desc = "Go to next diagnostic" },
		  { "gd", vim.lsp.buf.definition, desc = "LSP go to definition" },
		  { "gi", vim.lsp.buf.implementation, desc = "LSP go to implementation" },
		  { "gn", vim.lsp.buf.rename, desc = "LSP rename" },
		  { "gr", vim.lsp.buf.references, desc = "LSP list references" },
		  { "gs", vim.lsp.buf.signature_help, desc = "LSP signature help" },
	  }, {
		  mode = 'n',
		  silent = true,
	  })
        end,
      })
    end,
  },
}
