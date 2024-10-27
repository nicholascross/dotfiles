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

      openai_params = {
        model = "gpt-4o-2024-08-06",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 0.2,
        top_p = 0.1,
        n = 1,
      }
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",      -- optional
    "nvim-telescope/telescope.nvim",
  },
}
