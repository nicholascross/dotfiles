-- Enable highlighting for swiftinterface files
vim.filetype.add({ extension = { swiftinterface = "swift" } })

vim.api.nvim_create_autocmd('BufRead', {
  pattern = '*.swiftinterface',
  callback = function()
    -- Disable diagnostic since this is readonly
    vim.diagnostic.enable(false)
  end
})
