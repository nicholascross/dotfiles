function CopyToClipboard()
  local start_line = vim.fn.line("'<")
  local start_col = vim.fn.col("'<")
  local end_line = vim.fn.line("'>")
  local end_col = vim.fn.col("'>")

  ---@type string[]
  ---@diagnostic disable-next-line: assign-type-mismatch
  local lines = vim.fn.getline(start_line, end_line)

  lines[1] = string.sub(lines[1], start_col, #lines[1])
  lines[#lines] = string.sub(lines[#lines], 1, end_col)

  local text_to_copy = table.concat(lines, "\n")
  vim.fn.system("printf '%s' " .. vim.fn.shellescape(text_to_copy) .. " | pbcopy")
end
