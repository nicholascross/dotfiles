local wk = require("which-key")
local builtin = require('telescope.builtin')

wk.add({
  -- File browsing
  { "<leader>f", group = "Telescope" },
  { "<leader>fb", builtin.buffers, desc = "Buffers" },
  { "<leader>ff", builtin.find_files, desc = "Find Files" },
  { "<leader>fg", builtin.live_grep, desc = "Live Grep", icon="󰑑" },
  { "<leader>fr", builtin.registers, desc = "Registers", icon="󱘢" },
  { "<leader>fs", builtin.symbols, desc = "Symbols", icon="" },
  { "<leader>ft", builtin.treesitter, desc = "Tree Sitter", icon="" },
  { "<leader>fh", builtin.help_tags, desc = "Help Tags", icon="󰋖" },
  { "<leader>fa", builtin.builtin, desc = "Telescope", icon="" },

  -- File management
  { "<space>-", require("oil").toggle_float, desc = "Open file browser" },

  -- Indentation
  { "<Tab>", ">>", mode = { "n" } },
  { "<S-Tab>", "<<", mode = { "n" } },
  { "<Tab>", ">gv", mode = { "v" } },
  { "<S-Tab>", "<gv", mode = { "v" } },

   -- Move to previous/next
  { "<A-,>", "<Cmd>BufferPrevious<CR>", desc = "Move to previous buffer" },
  { "<A-.>", "<Cmd>BufferNext<CR>", desc = "Move to next buffer" },
  
  -- Re-order to previous/next
  { "<A-<>", "<Cmd>BufferMovePrevious<CR>", desc = "Re-order to previous buffer" },
  { "<A->>", "<Cmd>BufferMoveNext<CR>", desc = "Re-order to next buffer" },
  
  -- Goto buffer in position...
  { "<A-1>", "<Cmd>BufferGoto 1<CR>", desc = "Goto buffer 1" },
  { "<A-2>", "<Cmd>BufferGoto 2<CR>", desc = "Goto buffer 2" },
  { "<A-3>", "<Cmd>BufferGoto 3<CR>", desc = "Goto buffer 3" },
  { "<A-4>", "<Cmd>BufferGoto 4<CR>", desc = "Goto buffer 4" },
  { "<A-5>", "<Cmd>BufferGoto 5<CR>", desc = "Goto buffer 5" },
  { "<A-6>", "<Cmd>BufferGoto 6<CR>", desc = "Goto buffer 6" },
  { "<A-7>", "<Cmd>BufferGoto 7<CR>", desc = "Goto buffer 7" },
  { "<A-8>", "<Cmd>BufferGoto 8<CR>", desc = "Goto buffer 8" },
  { "<A-9>", "<Cmd>BufferGoto 9<CR>", desc = "Goto buffer 9" },
  { "<A-0>", "<Cmd>BufferLast<CR>", desc = "Goto last buffer" },
  
  -- Pin/unpin buffer
  { "<A-p>", "<Cmd>BufferPin<CR>", desc = "Pin/unpin buffer" },
  
  -- Close buffer
  { "<A-c>", "<Cmd>BufferClose<CR>", desc = "Close buffer" },
  
  -- Magic buffer-picking mode
  { "<C-p>", "<Cmd>BufferPick<CR>", desc = "Magic buffer-picking mode" },
  
  -- Sort automatically by...
  { "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", desc = "Sort by buffer number" },
  { "<leader>bn", "<Cmd>BufferOrderByName<CR>", desc = "Sort by name" },
  { "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>", desc = "Sort by directory" },
  { "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", desc = "Sort by language" },
  { "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", desc = "Sort by window number" },

  { "<leader>y", ":lua CopyToClipboard()<CR>", desc = "Yank to system clipboard", mode = { "v" } },

  { "K", vim.lsp.buf.hover, desc = "LSP hover info" },
  { "[g", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic" },
  { "gD", vim.lsp.buf.declaration, desc = "LSP go to declaration" },
  { "g]", vim.diagnostic.goto_next, desc = "Go to next diagnostic" },
  { "gd", vim.lsp.buf.definition, desc = "LSP go to definition" },
  { "gi", vim.lsp.buf.implementation, desc = "LSP go to implementation" },
  { "gn", vim.lsp.buf.rename, desc = "LSP rename" },
  { "gr", vim.lsp.buf.references, desc = "LSP list references" },
  { "gs", vim.lsp.buf.signature_help, desc = "LSP signature help" },

  -- Debug
  { "<leader>d", group = "Debug", icon = "" },
  { "<leader>db", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint", icon = "" },
  { "<leader>dc", "<Cmd>lua require'dap'.continue()<CR>", desc = "Continue", icon = "" },
  { "<leader>di", "<Cmd>lua require'dap'.step_into()<CR>", desc = "Step Into", icon = "" },
  { "<leader>do", "<Cmd>lua require'dap'.step_over()<CR>", desc = "Step Over", icon = "" },
  { "<leader>dO", "<Cmd>lua require'dap'.step_out()<CR>", desc = "Step Out", icon = "" },
  { "<leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", desc = "Open REPL", icon = "" },
  { "<leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", desc = "Run Last", icon = "ﰇ" },
  { "<leader>du", "<Cmd>lua require'dapui'.toggle()<CR>", desc = "Toggle Dap UI", icon = "" },
})

