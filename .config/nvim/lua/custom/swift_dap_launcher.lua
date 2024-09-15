local user_paths = {
  '.build/debug',
  '~/Library/Developer/Xcode/DerivedData/*/Build/Products/Debug'
}

local function check_paths_exist(paths)
  local fn = vim.fn
  for _, path in ipairs(paths) do
    local expanded_paths = fn.glob(path, 0, 1)
    if #expanded_paths > 0 then
      return true
    end
  end
  return false
end

local function build_find_command(paths)
  local find_command = 'find'
  for _, path in ipairs(paths) do
    find_command = find_command .. ' ' .. path .. '/'
  end
  find_command = find_command .. ' -type f -perm +111 -exec stat -f "%m %N" {} + | sort -n | tail -n 5'
  return find_command
end

local function execute_command(command)
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  return result
end

-- Parse the find command result into a list of executables
local function parse_executables(result)
  local fn = vim.fn
  local executables = {}
  for line in result:gmatch("[^\r\n]+") do
    local _, path = line:match("([%d%.]+)%s+(.+)")
    if path then
      table.insert(executables, fn.expand(path))
    end
  end
  return executables
end

local function start_debugging(program, args)
  local run_config = {
    type = "codelldb",
    request = 'launch',
    name = "Launch executable",
    program = program,
    args = args,
  }
  require('dap').run(run_config)
end

local function prompt_for_arguments(choice)
  vim.ui.input({ prompt = "Arguments (leave blank for none): " }, function(args_input)
    local args = {}
    if args_input and args_input ~= '' then
      for arg in args_input:gmatch("%S+") do
        table.insert(args, arg)
      end
    end

    start_debugging(choice, args)
  end)
end

-- Prompt the user to select an executable using Telescope
local function prompt_user_selection(executables)
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values

  pickers.new({}, {
    prompt_title = 'Select Executable',
    finder = finders.new_table {
      results = executables
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local choice = action_state.get_selected_entry()[1]

        if not choice then
          print("No executable selected.")
          return
        end

        prompt_for_arguments(choice)
      end)
      return true
    end,
  }):find()
end

local M = {}

function M.find_executables()
  if not check_paths_exist(user_paths) then
    print("No valid build directories found.")
    return
  end

  local find_command = build_find_command(user_paths)
  local result = execute_command(find_command)

  if result == '' then
    print("No recent executables found.")
    return
  end

  local executables = parse_executables(result)
  prompt_user_selection(executables)
end

return M
