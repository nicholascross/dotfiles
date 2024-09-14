local live_grep_args = require("telescope").extensions.live_grep_args.live_grep_args

local M = {}

M.grep_word_under_cursor_same_type = function()
  local word_under_cursor = vim.fn.expand("<cword>")
  local extension = vim.fn.expand('%:e')
  local default_text = '"' .. word_under_cursor .. '"'

  if extension ~= '' then
    default_text = default_text .. " -t" .. extension
  end

  live_grep_args({ default_text = default_text })
end

return M
