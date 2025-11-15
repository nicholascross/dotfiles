return {
  "zbirenbaum/copilot.lua",
  cond = function()
    local enabled = true
    local home = vim.fn.expand("$HOME")
    -- Path to the Copilot authentication file
    local auth_file = home .. "/.config/github-copilot/apps.json"

    -- Check if the file exists and is readable
    return enabled and vim.fn.filereadable(auth_file) == 1
  end,
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
          accept = "<M-l>",
          next = "<M-j>",
          prev = "<M-k>",
          dismiss = "<M-h>",
        },
      },
      panel = { enabled = false },
    })

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = { "*.str", "*.std" },
      callback = function(args)
        vim.b[args.buf].copilot_suggestion_auto_trigger = true
      end,
    })

    vim.api.nvim_create_autocmd("BufLeave", {
      pattern = { "*.str", "*.std" },
      callback = function(args)
        vim.b[args.buf].copilot_suggestion_auto_trigger = false
      end,
    })
  end,
}
