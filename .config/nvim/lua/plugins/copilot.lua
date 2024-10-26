return {
  "zbirenbaum/copilot.lua",
  cond = function()
    local enabled = true
    local home = vim.fn.expand("$HOME")
    -- Path to the Copilot authentication file
    local auth_file = home .. "/.config/github-copilot/hosts.json"

    -- Check if the file exists and is readable
    return enabled and vim.fn.filereadable(auth_file) == 1
  end,
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
}
