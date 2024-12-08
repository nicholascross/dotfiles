local M = {}

local function parse_xcbeautify_output(lines)
  local tests, total_tests, total_failures = {}, 0, 0
  local has_error = false
  local error_lines = {}

  for _, line in ipairs(lines) do
    -- Detect compilation or build errors
    if line:match("error:") then
      has_error = true
      table.insert(error_lines, line)
    end

    -- Match passed tests
    local pass_name, pass_time = line:match("^%s*✔%s+([^%s]+)%s*%(([%d%.]+) seconds%)")
    if pass_name then
      table.insert(tests, { name = pass_name, time = pass_time, status = "passed" })
    end

    -- Match failed tests
    local fail_name, fail_message = line:match("^%s*✖%s+([^,]+),%s*(.+)$")
    if fail_name then
      table.insert(tests, { name = fail_name, message = fail_message, status = "failed" })
    end

    -- Match summary
    local executed, failures = line:match("^Executed%s+(%d+)%s+test[s]?,%s+with%s+(%d+)%s+failure[s]?")
    if executed and failures then
      total_tests = tonumber(executed) or 0
      total_failures = tonumber(failures) or 0
    end
  end

  return tests, total_tests, total_failures, has_error, error_lines
end

local function highlight_lines(buf, tests, total_failures)
  vim.api.nvim_buf_add_highlight(buf, -1, total_failures > 0 and "ErrorMsg" or "MoreMsg", 0, 0, -1)

  for i, test in ipairs(tests) do
    local hl_group = test.status == "failed" and "ErrorMsg" or "String"
    vim.api.nvim_buf_add_highlight(buf, -1, hl_group, i + 1, 0, -1)
  end
end

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
    table.sort(tests, function(a, b)
      return a.status == "failed" and b.status ~= "failed"
    end)

    local header = total_failures > 0 and " " .. total_failures .. " Tests Failed" or " " .. total_tests .. " Tests Passed"
    table.insert(summary_lines, header)
    table.insert(summary_lines, "")

    for _, test in ipairs(tests) do
      local icon = test.status == "passed" and "✓" or "✗"
      if test.status == "failed" and test.message then
        table.insert(summary_lines, string.format("%s %s: %s", icon, test.name, test.message))
      else
        table.insert(summary_lines, string.format("%s %s (%ss)", icon, test.name, test.time or ""))
      end
    end
  end

  vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, summary_lines)
  vim.api.nvim_buf_set_lines(new_buf, -1, -1, false, { "", "----- Logs -----", "" })
  vim.api.nvim_buf_set_lines(new_buf, -1, -1, false, original_lines)

  if has_error then
    vim.api.nvim_buf_add_highlight(new_buf, -1, "ErrorMsg", 0, 0, -1)
  else
    highlight_lines(new_buf, tests, total_failures)
  end

  vim.bo[new_buf].modifiable = false

  return new_buf
end

function M.attach_test_summary_handler(bufnr)
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = bufnr,
    once = true,
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local tests, total_tests, total_failures, has_error, error_lines = parse_xcbeautify_output(lines)

      local summary_buf = create_summary_buffer(bufnr, lines, tests, total_tests, total_failures, has_error, error_lines)

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
