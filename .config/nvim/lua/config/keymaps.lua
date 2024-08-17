local wk = require("which-key")
local builtin = require('telescope.builtin')

wk.add({
  -- File browsing
  { "<leader>f", group = "Telescope" },
  { "<leader>fb", builtin.buffers, desc = "Buffers" },
  { "<leader>ff", builtin.find_files, desc = "Find Files" },
  { "<leader>fg", builtin.live_grep, desc = "Live Grep" },
  { "<leader>fh", builtin.help_tags, desc = "Help Tags" },

  -- File management
  { "<space>-", require("oil").toggle_float, desc = "Open file browser" },

  -- Indentation
  { "<Tab>", ">>", mode = { "n" } },
  { "<S-Tab>", "<<", mode = { "n" } },
  { "<Tab>", ">gv", mode = { "v" } },
  { "<S-Tab>", "<gv", mode = { "v" } },
})

