return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  cond = function()
    -- Attempt to retrieve the API key from macOS keychain
    local api_key = vim.fn.system(
      "security find-generic-password -s OPENAI_APIKEY -w 2>/dev/null"
    )
    -- Remove any trailing whitespace (including newlines)
    api_key = api_key and api_key:gsub("%s+", "")
    -- Load the plugin only if the API key is available
    return api_key ~= nil and api_key ~= ''
  end,
  config = function()
    require("chatgpt").setup({
      -- Use the macOS keychain to retrieve the API key
      api_key_cmd = "security find-generic-password -s OPENAI_APIKEY -w",
      -- Add any other configuration options here
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",      -- optional
    "nvim-telescope/telescope.nvim",
  },
}
