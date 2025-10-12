return {
  "folke/sidekick.nvim",
  event = "VeryLazy",
  dependencies = {
    "zbirenbaum/copilot.lua",
  },
  init = function()
    local ok, wk = pcall(require, "which-key")
    if ok then
      wk.add({
        { "<leader>a", group = "Sidekick", icon = "", mode = { "n", "x" } },
      })
    end
  end,
  keys = {
    {
      "<tab>",
      function()
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>"
        end
      end,
      mode = { "i", "n" },
      expr = true,
      desc = "Sidekick: Goto/Apply Next Edit",
    },
    {
      "<c-.>",
      function()
        require("sidekick.cli").toggle()
      end,
      mode = { "n", "t", "i", "x" },
      desc = "Sidekick: Toggle CLI",
    },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick: Toggle CLI",
    },
    {
      "<leader>aF",
      function()
        require("sidekick.cli").focus()
      end,
      desc = "Sidekick: Focus CLI",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").select()
      end,
      desc = "Sidekick: Select Tool",
    },
    {
      "<leader>ad",
      function()
        require("sidekick.cli").close()
      end,
      desc = "Sidekick: Detach Session",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "n", "x" },
      desc = "Sidekick: Send This",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Sidekick: Send File",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Sidekick: Send Selection",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Sidekick: Prompt Library",
    },
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle({ name = "claude", focus = true })
      end,
      desc = "Sidekick: Toggle Claude",
    },
    {
      "<leader>an",
      function()
        require("sidekick.nes").update()
      end,
      desc = "Sidekick: Refresh Next Edit",
    },
  },
  opts = {
    cli = {
      mux = {
        backend = "zellij",
        enabled = true,
      },
    },
  },
}
