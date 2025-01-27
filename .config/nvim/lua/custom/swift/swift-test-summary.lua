local log_parser = require('custom/swift/xcbeautify-parser')

local M = {}

--------------------------------------------------------------------------------
-- Highlight lines in the summary
--------------------------------------------------------------------------------
local function highlight_lines(buf, tests, total_failures)
  vim.api.nvim_buf_add_highlight(
    buf,
    -1,
    total_failures > 0 and "ErrorMsg" or "MoreMsg",
    0, 0, -1
  )

  for i, test in ipairs(tests) do
    local hl_group = test.status == "failed" and "ErrorMsg" or "String"
    vim.api.nvim_buf_add_highlight(buf, -1, hl_group, i + 1, 0, -1)
  end
end

--------------------------------------------------------------------------------
-- Creates a new buffer to show a summary of test results
--------------------------------------------------------------------------------
local function create_summary_buffer(original_buf, original_lines, tests, total_tests, total_failures, has_error, error_lines)
  local new_buf = vim.api.nvim_create_buf(true, false)
  vim.bo[new_buf].buftype = "nofile"
  vim.bo[new_buf].bufhidden = "hide"

  local original_name = vim.api.nvim_buf_get_name(original_buf)
  if original_name and original_name ~= "" then
    vim.api.nvim_buf_set_name(new_buf, original_name .. " (summary)")
  end

  local summary_lines = {}

  if has_error then
    table.insert(summary_lines, " Build Failed")
    for _, error in ipairs(error_lines) do
      table.insert(summary_lines, error)
    end
  else
    -- Sort so that any failed tests appear first
    table.sort(tests, function(a, b)
      return a.status == "failed" and b.status ~= "failed"
    end)

    local header = (total_failures > 0)
      and (" " .. total_failures .. " Tests Failed")
      or  (" " .. total_tests .. " Tests Passed")

    table.insert(summary_lines, header)
    table.insert(summary_lines, "")

    for _, test in ipairs(tests) do
      local icon = (test.status == "failed") and "✗" or "✓"
      local time_str = test.time and (" (" .. test.time .. "s)") or ""

      if test.status == "failed" and test.message then
        table.insert(summary_lines,
          string.format("%s %s: %s", icon, test.name, test.message))
      else
        table.insert(summary_lines,
          string.format("%s %s%s", icon, test.name, time_str))
      end
    end
  end

  -- Print summary lines, then logs
  vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, summary_lines)
  vim.api.nvim_buf_set_lines(new_buf, -1, -1, false, { "", "----- Logs -----", "" })
  vim.api.nvim_buf_set_lines(new_buf, -1, -1, false, original_lines)

  -- Highlighting
  if has_error then
    vim.api.nvim_buf_add_highlight(new_buf, -1, "ErrorMsg", 0, 0, -1)
  else
    highlight_lines(new_buf, tests, total_failures)
  end

  vim.bo[new_buf].modifiable = false
  return new_buf
end

--------------------------------------------------------------------------------
-- Attaches an auto-command to show a test summary when the terminal buffer closes
--------------------------------------------------------------------------------
function M.attach_test_summary_handler(bufnr)
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = bufnr,
    once = true,
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

      local tests, total_tests, total_failures, has_error, error_lines =
        log_parser.parse_test_output(lines)

      local summary_buf = create_summary_buffer(
        bufnr,
        lines,
        tests,
        total_tests,
        total_failures,
        has_error,
        error_lines
      )

      local win = vim.fn.bufwinnr(bufnr)
      if win ~= -1 then
        vim.cmd(win .. "wincmd w")
        vim.api.nvim_win_set_buf(0, summary_buf)
      end

      vim.api.nvim_buf_delete(bufnr, { force = true })
    end,
  })
end

return M
