return {
  "nvim-pack/nvim-spectre",
  config = function()
    require('spectre').setup({
      mapping={
        ['send_to_qf'] = {
          map = "<leader>x",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all items to quickfix"
        },
      },
      replace_engine = {
        ["sed"] = {
          cmd = "sed",
          args = {
            "-i",
            "",
            "-E",
          },
        },
      }
    })
  end
}
