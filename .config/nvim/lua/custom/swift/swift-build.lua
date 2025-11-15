local terminal = require('custom/utils/terminal')
local swift_package = require('custom/swift/swift-package')
local swift_test_summary = require('custom/swift/swift-test-summary')

local M = {}

local function select_product(prompt, callback)
  local package_path = swift_package.path()

  if not package_path then
    vim.notify("Not a Swift package", vim.log.levels.ERROR)
    return
  end

  local products = swift_package.products(package_path)
  if #products == 0 then
    vim.notify("No products found", vim.log.levels.WARN)
    return
  end

  vim.ui.select(products, { prompt = prompt }, function(selected)
    if not selected then
      vim.notify("Selection cancelled", vim.log.levels.DEBUG)
      return
    end
    callback(package_path, selected)
  end)
end

function M.build_swift_package()
  select_product("Select Product to Build:", function(package_path, product)
    local cmd = "cd " .. vim.fn.shellescape(package_path) .. " && swift build --product " .. vim.fn.shellescape(product)
    local term_buf = terminal.open(cmd, "swift build " .. product)
    if term_buf then
      vim.b[term_buf].swift_related = true
      vim.api.nvim_exec_autocmds("BufEnter", { buffer = term_buf })
    end
  end)
end

function M.run_swift_package()
  select_product("Select Product to Run:", function(package_path, product)
    local cmd = "cd " .. vim.fn.shellescape(package_path) .. " && swift run " .. vim.fn.shellescape(product)
    local term_buf = terminal.open(cmd, "swift run " .. product)
    if term_buf then
      vim.b[term_buf].swift_related = true
      vim.api.nvim_exec_autocmds("BufEnter", { buffer = term_buf })
    end
  end)
end

function M.test_swift_package(filter)
  local package_path = swift_package.path()

  if not package_path then
    vim.notify("Not a Swift package", vim.log.levels.ERROR)
    return
  end

  local testCMD = filter and "swift test --filter " .. filter or "swift test"
  local cmd = "cd " .. vim.fn.shellescape(package_path) .. " && " .. testCMD .. " | xcbeautify"
  local term_buf = terminal.open(cmd, "swift test")
  if term_buf then
    vim.b[term_buf].swift_related = true
    vim.api.nvim_exec_autocmds("BufEnter", { buffer = term_buf })
  end
  swift_test_summary.attach_test_summary_handler(term_buf)
end

function M.test_swift_package_test()
  local word_under_cursor = vim.fn.expand("<cword>")
  return M.test_swift_package(word_under_cursor)
end

return M
