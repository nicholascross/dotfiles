local M = {}

--[[
  Displays window numbers overlaid on each window in the current tab.
  Allows the user to select a window by pressing the corresponding number key.
]]
function M.show_window_numbers()
  local api = vim.api
  local fn = vim.fn
  local wins = api.nvim_tabpage_list_wins(0)
  local float_wins = {}
  local win_map = {}

  -- Display window numbers
  for idx, win in ipairs(wins) do
    -- Create a scratch buffer
    local buf = api.nvim_create_buf(false, true)
    -- Prepare window number string
    local number_str = ' ' .. tostring(idx) .. ' '
    api.nvim_buf_set_lines(buf, 0, -1, false, { number_str })

    -- Calculate the position to center the floating window
    local width = api.nvim_win_get_width(win)
    local height = api.nvim_win_get_height(win)
    local win_width = fn.strdisplaywidth(number_str)
    local win_height = 1
    local col = math.floor((width - win_width) / 2)
    local row = math.floor(height / 2)

    -- Floating window options
    local opts = {
      style = 'minimal',
      relative = 'win',
      win = win,
      width = win_width,
      height = win_height,
      row = row,
      col = col,
      focusable = false,
      zindex = 100,
      border = 'rounded',
    }

    -- Open the floating window
    local float_win = api.nvim_open_win(buf, false, opts)
    table.insert(float_wins, { win = float_win, buf = buf })
    win_map[tostring(idx)] = win  -- Use string keys for consistency
  end

  api.nvim_command('redraw')

  -- Function to clean up floating windows and buffers
  local function cleanup()
    for _, item in ipairs(float_wins) do
      if api.nvim_win_is_valid(item.win) then
        api.nvim_win_close(item.win, true)
      end
      if api.nvim_buf_is_valid(item.buf) then
        api.nvim_buf_delete(item.buf, { force = true })
      end
    end
  end

  -- Get user input
  local ok, input_code = pcall(fn.getchar)
  if not ok then
    -- getchar() was interrupted
    cleanup()
    return
  end

  if input_code == 27 then  -- ESC key code
    cleanup()
    return
  end

  local input_char = fn.nr2char(input_code)
  local target_win = win_map[input_char]
  if target_win then
    api.nvim_set_current_win(target_win)
  else
    api.nvim_echo({ { 'Invalid window number: ' .. input_char, 'ErrorMsg' } }, true, {})
  end

  cleanup()
end

return M
