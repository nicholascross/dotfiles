local live_grep_args = require("telescope").extensions.live_grep_args.live_grep_args

local M = {}

M.grep_cursor = function()
  local word_under_cursor = vim.fn.expand("<cword>")
  local extension = vim.fn.expand('%:e')
  local default_text = '"' .. word_under_cursor .. '"'

  if extension ~= '' then
    default_text = default_text .. " -t" .. extension
  end

  live_grep_args({ default_text = default_text })
end

M.find_cursor = function()
  require('telescope.builtin').find_files { find_command = { "fd", "--type", "f", "--glob", "*" .. vim.fn.expand("<cword>") .. "*" } }
end

return M
