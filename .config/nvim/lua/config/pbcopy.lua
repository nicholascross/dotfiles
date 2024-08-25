function CopyToClipboard()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.fn.getline(start_line, end_line)
  local text_to_copy = table.concat(lines, "\n")
  vim.fn.system("printf '%s' " .. vim.fn.shellescape(text_to_copy) .. " | pbcopy")
end
