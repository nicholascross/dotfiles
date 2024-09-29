return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    select = {
      enabled = true, -- Enable the select UI
      backend = "telescope", -- Options: 'nui', 'builtin', 'telescope', 'fzf_lua', etc.
      nui = { position = "50%", size = nil, relative = "editor", border = { style = "rounded" }, buf_options = { swapfile = false, filetype = "NoiceSelect" }, win_options = { winblend = 10 } }
    }
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify"
  }
}
