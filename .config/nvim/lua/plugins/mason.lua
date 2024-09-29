return {
  "williamboman/mason.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-nvim-dap").setup({
      -- install dependency required for swift debugging
      ensure_installed = { "codelldb", "lua_ls" },
      automatic_setup = true,
    })
  end,
}
