local M = {}

local ERROR_PATTERN      = "error:"
local PASS_PATTERN       = "^%s*\u{2714}%s+([^%s]+)%s*%(([%d%.]+)%s+seconds%)"
local FAIL_XCTEST_PATTERN    = "^%s*\u{2716}%s+([^,]+),%s*(.+)$"
local FAIL_SWIFT_PATTERN = "^%s*\u{2716}%s+([%w_%.%(%)]+)%s*%(([%d%.]+)%s+seconds%)%s+([%d]+%s+issue%(s%))"


local function detect_build_error(line, state)
  if line:match(ERROR_PATTERN) then
    state.has_error = true
    table.insert(state.error_lines, line)
  end
end

local function detect_passing_test(line, state)
  local pass_name, pass_time = line:match(PASS_PATTERN)
  if pass_name and pass_time then
    table.insert(state.tests, {
      name   = pass_name,
      time   = pass_time,
      status = "passed"
    })
    state.total_tests = state.total_tests + 1
  end
end

local function detect_failing_test(line, state)
  -- XCTest style
  local fail_name_xc, fail_msg_xc = line:match(FAIL_XCTEST_PATTERN)
  if fail_name_xc then
    table.insert(state.tests, {
      name    = fail_name_xc,
      status  = "failed",
      message = fail_msg_xc
    })
    state.total_failures = state.total_failures + 1
    state.total_tests = state.total_tests + 1
  end

  -- Swift Testing style
  local fail_name_swift, fail_time_swift, fail_issues_swift =
    line:match(FAIL_SWIFT_PATTERN)
  if fail_name_swift and fail_time_swift then
    table.insert(state.tests, {
      name    = fail_name_swift,
      time    = fail_time_swift,
      status  = "failed",
      message = fail_issues_swift
    })
    state.total_failures = state.total_failures + 1
    state.total_tests = state.total_tests + 1
  end
end

function M.parse_test_output(lines)
  local state = {
    tests            = {},
    total_tests      = 0,
    total_failures   = 0,
    has_error        = false,
    error_lines      = {},
    warnings_by_test = {}
  }

  for _, line in ipairs(lines) do
    detect_build_error(line, state)
    detect_passing_test(line, state)
    detect_failing_test(line, state)
  end


  return state.tests,
         state.total_tests,
         state.total_failures,
         state.has_error,
         state.error_lines
end

return M
