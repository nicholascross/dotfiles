return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-dap.nvim'
  },
  config = function()
    require('telescope').setup()
    require('telescope').load_extension('dap')
    require('telescope').load_extension('undo')
  end
}
