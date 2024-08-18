  return {'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      icons = {
        -- Possible values: true, 'superscript', 'subscript'
        buffer_index = 'superscript',
      },
    },
  }

