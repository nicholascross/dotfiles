return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Set this to "*" to always pull the latest release version, or false to update to the latest code changes.
  opts = {
    -- Set the default provider to "ollama"
    provider = "custom_openai",
    vendors = {
      ollama = {
        __inherited_from = "openai",    -- Inherit default functionality from the OpenAI provider
        api_key_name = "",              -- No API key needed for a local Ollama instance
        endpoint = "http://127.0.0.1:11434/v1",
        --model = "codegemma",
        model = "qwen2.5-coder:7b",
        --model = "qwen2.5-coder:14b",
        --model = "deepseek-r1:14b",
      },
      custom_openai = {
        __inherited_from = "openai",    -- Inherit default functionality from the OpenAI provider
        api_key_name = { "security", "find-generic-password", "-s", "avante", "-a", "openai", "-w" },
        model = "gpt-4o-mini",
      },
      promptly = {
        __inherited_from = "openai",    -- Inherit default functionality from the OpenAI provider
        api_key_name = "",
        endpoint = "http://127.0.0.1:8080",
      },
    },
  },
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- Optional dependencies for various providers or extra features:

    "nvim-telescope/telescope.nvim",     -- for file_selector provider telescope
    "hrsh7th/nvim-cmp",                  -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons",       -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua",            -- for providers='copilot'

    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
