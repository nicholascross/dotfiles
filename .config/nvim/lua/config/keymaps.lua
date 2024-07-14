local wk = require("which-key")
local builtin = require('telescope.builtin')

-- Define your key mappings
local mappings = {
  ["<leader>f"] = { name = "Telescope" },
  ["<leader>ff"] = { builtin.find_files, "Find Files" },
  ["<leader>fg"] = { builtin.live_grep, "Live Grep" },
  ["<leader>fb"] = { builtin.buffers, "Buffers" },
  ["<leader>fh"] = { builtin.help_tags, "Help Tags" },
}

-- Register the mappings
wk.register(mappings)
