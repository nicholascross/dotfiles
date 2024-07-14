vim.g.mapleader = " "

function CopyToClipboard()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.fn.getline(start_line, end_line)
  local text_to_copy = table.concat(lines, "\n")
  vim.fn.system("printf '%s' " .. vim.fn.shellescape(text_to_copy) .. " | pbcopy")
end

function PasteFromClipboard()
  if vim.fn.mode() == "v" then
    -- Delete the visual selection
    vim.cmd("normal! d")
  end
  local content = vim.fn.systemlist("pbpaste")
  vim.api.nvim_put(content, "c", false, true)
end

vim.api.nvim_set_keymap("v", "<leader>y", ":lua CopyToClipboard()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>p", ":lua PasteFromClipboard()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>p", ":<C-U>lua PasteFromClipboard()<CR>", { noremap = true, silent = true })
